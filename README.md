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
