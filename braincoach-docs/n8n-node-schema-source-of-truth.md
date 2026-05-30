# BrainCoach n8n Node Schema Source Of Truth

Last Updated: 2026-05-29

## Critical Rule

When generating n8n workflows, AI agents MUST use exported node schemas from the BrainCoach production n8n instance.

Do NOT generate node structures from memory.

Do NOT use generic internet examples.

Do NOT assume node parameter formats.

Always compare against exported production nodes.

---

## Production Node References

Location:

workflows/reference-node-exports/

Files:

* openai-node.json
* google-sheets-node.json
* if-node.json
* postgres-node.json
* telegram-node.json

These files are the source of truth.

---

## Verified OpenAI Node

Type:

@n8n/n8n-nodes-langchain.openAi

Version:

1.8

Important:

modelId must use Resource Locator structure.

Example:

{
"__rl": true,
"mode": "list",
"value": "gpt-5.4-mini"
}

messages must use:

{
"values": [...]
}

not a direct array.

---

## Verified Google Sheets Node

Version:

4.6

Important:

Use:

* documentId
* sheetName

Do NOT use:

* sheetId
* range

unless confirmed by exported schema.

---

## Verified IF Node

Version:

2.2

Use modern conditions schema.

Do NOT generate legacy boolean condition structures.

---

## Workflow Generation Rule

Before generating any workflow:

1. Load exported node references.
2. Match node versions exactly.
3. Match parameter structures exactly.
4. Only then generate workflow JSON.

Failure to follow this rule may produce workflows that cannot be imported into BrainCoach production n8n.

---

## Production Compatibility Principle

Repository architecture may be generated.

Node schemas may NOT be generated.

Node schemas must always come from exported production examples.
