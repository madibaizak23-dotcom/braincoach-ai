# n8n Compatibility Notes

Last Updated: 2026-05-29

## OpenAI Node Compatibility

BrainCoach production n8n instance uses:

```json
{
  "type": "@n8n/n8n-nodes-langchain.openAi",
  "typeVersion": 1.8
}
```

Do NOT generate workflows using:

```json
{
  "type": "n8n-nodes-base.openAi"
}
```

because this node format is not compatible with the current BrainCoach n8n environment.

---

## Supported Models

Verified models:

* gpt-5.4-nano
* gpt-5.4-mini
* gpt-5.4

Recommended mapping:

### GPT-5.4-NANO

Use for:

* intake classifier
* emotional reflection
* memory extraction
* booking engine
* followup engine

### GPT-5.4-MINI

Use for:

* qualification engine
* offer generator

### GPT-5.4

Use only for:

* advanced reasoning
* premium analysis
* future expert workflows

---

## Workflow Generation Rule

When generating n8n workflow JSON:

1. Use actual exported node formats from this n8n instance.
2. Do not assume generic n8n node structures.
3. Validate node types against exported examples before generating production workflows.
