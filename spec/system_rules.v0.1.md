# System Rules v0.1 (Authoritative)

本文件定义“小鸽 v0”系统级状态评估与建议的行为规则。
它是业务规则真相之一，必须与 OpenAPI/AgentTools 保持一致。

## 0. 范围
- 仅覆盖 v0 的占位评估逻辑（可运行、可验收、可迭代）
- 不做医学诊断，不做个体化治疗建议

## 1. 系统与核心标志物 (v0)
系统代码 system_code_enum：

- energy: 核心标志物 = ["rhr", "hrv"]
- metabolic: 核心标志物 = ["fpg"]

说明：
- “核心标志物齐全”仅表示 v0 可给出占位状态，不代表健康结论。

## 2. 状态机 (v0)
系统状态 system_state_enum 的含义（v0 简化）：

- invisible：核心标志物缺失，状态不可见
- limited：核心标志物部分缺失或数据质量不足（v0 暂不启用，可预留）
- normal：核心标志物齐全（v0 固定返回 normal 作为占位）
- impaired：v0 暂不启用（未来接入阈值/评分再使用）

v0 规则：
- 若 missing_core 非空 → system_state = "invisible"
- 若 missing_core 为空 → system_state = "normal"

## 3. Freshness / 时效性 (v0)
v0 暂不做复杂 freshness 推理：
- API 返回中可带 freshness_state，但不影响 system_state（后续 v0.2 接入 FreshnessEngine）

## 4. Recommendations (v0)
- recommendations 为占位建议，必须与 system_state 一致：
  - invisible：提示补测核心标志物
  - normal：提示“核心标志物已齐（占位状态）”，不提供治疗方案

## 5. 数据真相与边界
- 任何系统状态/建议只能基于数据库中该 user_id 的观测数据
- 不允许“脑补缺失值”
- 不允许绕过 OpenAPI 直连数据库
