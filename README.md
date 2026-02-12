# Xiaoge v0 API

## Architecture Rules

1. All Agent/LLM calls MUST use tools defined in `spec/agent_tools.v0.1.json`
2. Direct database access by Agent is strictly prohibited
3. Business logic must flow through OpenAPI endpoints
4. The database schema is not considered an API contract
5. The only external contract is:
   - spec/openapi.v0.1.yaml
   - spec/agent_tools.v0.1.json

Violation of these rules breaks system integrity.


## One-click Acceptance (Agent Playbook)

Prerequisites:
- API server is running at `http://127.0.0.1:8000`
- `.env` has valid `DATABASE_URL`

Run:
```bash
pip install -r requirements.txt
python3 scripts/agent_playbook_v0_1.py
```