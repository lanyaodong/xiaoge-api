

---
《API 行为约束 Spec v0.1》
适用范围：OpenAPI v0.1 所有 endpoints + Postgres schema v0.1（8表）
优先级：本 Spec > PRD（解释层面）> 其它文档
原则：可解释、可追溯、不臆测、不诊断

---
1. 核心不变量
1. 系统只有“状态”没有“评分”
system_state_enum ∈ {ideal, normal, limited, impaired, invisible}
2. “状态不可见”是合法结果，不等同于“正常/理想”
invisible 只代表：关键数据不足或不可用（freshness/缺失/不可用）。
3. 任何结论必须可追溯到证据观测值
system_state 返回必须包含：
- used_observations（观测 id 列表或可追溯键）
- missing_biomarkers（缺哪些）
- freshness_notes / accuracy_notes（为什么置信度受限）
4. 不臆测缺失数据
缺失/不可用 → 不推断、不填补、不做均值。

---
1. 数据选择与归并（Observations Selection）
用于：refresh、get system state、get recommendations 的统一取数逻辑。
1.1 取数“候选集”范围
对某个 user + biomarker_code，候选值来自 biomarker_observations：
- measured_at 有值（必填）
- freshness_state != unknown（unknown 视为不可用于评估，但可展示）
1.2 同一标志物多来源冲突（同时间窗）
优先级选择（从高到低）：
1. accuracy_tier = gold
2. accuracy_tier = standard
3. accuracy_tier = low
4. accuracy_tier = unknown
若 accuracy 相同，按：
- measured_at 最新优先
- 若仍冲突：取 value_json 里 source_confidence 更高者（如无则取最新）
结果：每个 (user_id, biomarker_code) 评估时只用 1 条“preferred observation”。
但数据库里可以保留全部记录。
1.3 生物样本约束（已在 DB check）
- observation_medium = bio_sample → sample_type 必须非空
违反则插入失败（这是正确行为）。

---
2. Freshness / 可用性如何影响系统状态
这里不写阈值天数，只写“逻辑”。阈值进 calculation_rules.rule_json 或后续 Spec。
2.1 Freshness 三态语义
- fresh：可用于评估且不降低置信度
- stale：仍可用于评估，但必须降低置信度并提示
- expired：等同缺失（不可用于评估）
2.2 核心/辅助标志物规则（按系统语境）
每个系统有一组“关键标志物最小集”（= core + auxiliary），由 calculation_rules 提供映射。
- 若任一核心标志物为 missing 或 freshness=expired → 该系统状态必须为 invisible
- 若核心都可用（fresh 或 stale）但存在 stale → 系统可评估，但置信度受限
- 辅助标志物：
  - missing 或 expired 不会导致 invisible
  - 但会触发“数据不足/置信度受限”提示（见 3）

---
3. 置信度（Confidence）在 v0 的呈现与触发
3.1 v0 不输出数值/等级条
不返回 “low/medium/high” 字段。只返回文字化原因：
- confidence_notes（数组文本）
- missing_biomarkers（数组）
- stale_biomarkers（数组）
- accuracy_notes（数组）
3.2 触发“置信度受限”的最小条件
满足任一即触发：
- 任一核心标志物 stale
- 辅助标志物缺失达到规则阈值（阈值写在 rule_json；v0 默认：缺失 ≥1 即提示）
- 同一标志物存在冲突（同窗口多值且差异超规则阈值；阈值写在 rule_json）
- accuracy_tier = low/unknown 被用于评估（必须提示）

---
4. 系统状态判定规则（不写具体阈值，但写结构）
系统状态由 calculation_rules.rule_json 决定。后端必须遵守以下结构：
4.1 判定流程（固定）
对每个 system_code：
1. 取本系统所需关键标志物（core/aux 列表）
2. 取每个 biomarker_code 的 preferred observation（见 1）
3. 检查核心标志物可用性（见 2.2）
  - 不满足 → system_state = invisible，并返回 missing/expired 的原因
4. 若可评估 → 按 rule_json 的区间/逻辑输出 ideal/normal/limited/impaired
5. 输出 explanation 必须说明：
  - 主要拉动因素（top contributors）
  - 依据的观测值时间（measured_at）
4.2 “状态变化说明”必须可生成
当 refresh 后状态与上一次不同，返回：
- change_summary：一句话（哪些新数据导致变化）
- used_observations_delta：新增使用了哪些观测
v0 只要能生成文本说明即可；不需要历史状态锁定。

---
5. 行动建议触发（Recommendations Trigger）
5.1 何时产生建议
- system_state ∈ {limited, impaired} → 必须生成建议（至少 1 条）
- system_state = invisible → 只生成“补充数据”建议（见 5.3）
- system_state ∈ {ideal, normal} → 默认不生成，除非用户主动触发（由前端/agent调用触发）
5.2 建议类型与排序（统一）
建议类型固定为三类：
1. behavior_change（行为调整）
2. data_completion（补充数据）
3. product_service（商品服务）
排序固定：
behavior_change > data_completion > product_service
不是每次必须三类都出现；按触发规则决定。
5.3 invisible 时的特殊规则（重点）
当 system_state = invisible：
- 必须给 data_completion（明确缺哪些标志物）
- 允许给“测量类商品服务”但仅用于获取缺失标志物（不是干预类）
- 不给行为调整（避免在系统未解锁时给“干预方向”）
- 不给干预商品（补剂/疗法等）
“测量类商品服务”的判定：
- 产品在 products_services 中，且其 meta_json 或 category（若有）标记为 measurement / test / device
- 或 rule_json 指定该 biomarker 的 recommended_tools 列表

---
6. 商品服务推荐的商业与展示约束（零佣金）
当 recommendations 或 products 列表返回时，后端必须确保：
- commission_cny 恒为 0（如不是 0，视为数据错误，返回时必须归零并打 warning）
- 若 has_member_discount=false → member_price_cny 可为空
- 若 has_member_discount=true → member_price_cny 必须非空，且可计算 savings_cny（允许为空但建议填）
返回字段中必须允许前端展示：
- 会员价/市场价/已省/佣金=0 的透明信息

---
7. 证据链（Evidence Labeling）
7.1 适用范围
以下输出必须可带 evidence_links（名称+可点击链接）：
- recommendations 的“理由”
- system_state 的“解释”中涉及医学结论性描述时
7.2 最小要求
每条 evidence：
- title（名称）
- url（可点击链接）
可选：
- source_type（guideline / rct / meta / consensus / review）
- year
若无法提供 url：
- 必须明确标注 “无可点击链接（待补）” 并降低推荐优先级（仅内部提示，不需要对用户说“降低优先级”）

---
8. API 幂等与可重复调用（落地要求）
8.1 POST /observations
- 允许重复提交同一观测（不要求去重）
- 若要去重：以 (user_id, biomarker_code, measured_at, value_num/value_text/value_json hash) 做软去重（v0可不做）
8.2 POST /refresh
- refresh 是幂等的：同一数据集 refresh 多次，返回一致结果
- refresh 产出应写入：
  - calculation_rules 不写；system_assessments（若 v0未建该表则只返回不落库）
  - v0 当前 schema 没有 system_assessments 表：则 refresh 只做计算并返回（纯函数式）
备注：你当前 8表 schema 没有 system_assessments/recommendations 表，所以 v0 后端建议采用：
- refresh：即时计算返回
- get system-states：即时计算返回
- get recommendations：即时计算返回
之后 v0.2 再补评估落库表。

---
9. 错误处理（必须一致）
- 400：字段缺失/枚举非法/json 不合法
- 409：违反强约束（例如触发器阻止主系统写入扩展表）
- 422：业务不可评估（可选；也可以返回 200 + state=invisible，v0建议用 200）
- 500：未捕获异常（必须带 request_id）

---
10. 与前端/Agent 的协作契约（最低要求）
- 所有“不可见/置信度受限/冲突”都必须有可展示的文本理由（数组）
- 前端/Agent 不得自己推断状态；只能展示后端结果
- 对话型解释可以由 Agent 生成，但必须引用后端返回的：
  - used_observations
  - missing/stale 列表
  - evidence_links

---
附：v0 推荐落地实现策略（给 B 用）
1. calculation_rules.rule_json 里维护：
- 每个 system_code 的核心/辅助 biomarker_code 列表
- 每个 biomarker 的 freshness window（先写死）
- 分档阈值（先写死）
2. 后端先实现“规则引擎最小版”：
- 只支持 number 类型 value_num
- 先覆盖 6 系统的关键标志物最小集
3. recommendations 先只生成 1~3 条即可（每系统）

---
