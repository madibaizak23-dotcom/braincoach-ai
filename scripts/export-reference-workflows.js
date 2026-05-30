#!/usr/bin/env node
/*
Export reference workflows from n8n and save them to workflows/reference-node-exports/

Usage (when running):
  N8N_URL=https://n8n.example.com N8N_API_KEY=xxxxx node scripts/export-reference-workflows.js

Notes:
- This script only prepares exports; it will list workflows and fetch full workflow JSON.
- It supports both /workflows and /rest/workflows API path variants (tries both).
- It expects the n8n API to accept the header `X-N8N-API-KEY: <key>`.
- Do NOT execute this script until you review and provide credentials.
*/

const fs = require('fs');
const path = require('path');

// Load environment from .env when available (optional)
try { require('dotenv').config(); } catch (e) {}

const N8N_URL = process.env.N8N_URL;
const N8N_API_KEY = process.env.N8N_API_KEY;

if (!N8N_URL || !N8N_API_KEY) {
  console.error('Missing N8N_URL or N8N_API_KEY environment variables.');
  console.error('This script is only a prepared implementation. Do not run without setting these.');
  process.exitCode = 1;
}

const OUT_DIR = path.join(__dirname, '..', 'workflows', 'reference-node-exports');

async function fetchJson(url, opts = {}) {
  const res = await fetch(url, opts);
  if (!res.ok) throw new Error(`HTTP ${res.status} ${res.statusText} for ${url}`);
  return res.json();
}

async function tryApiPaths() {
  // n8n API path variants
  const baseCandidates = [
    `${N8N_URL.replace(/\/$/, '')}`,
    `${N8N_URL.replace(/\/$/, '')}/rest`,
  ];
  const paths = baseCandidates.map(b => ({
    list: `${b}/workflows`,
    get: id => `${b}/workflows/${id}`,
  }));
  return paths;
}

function safeFileName(name) {
  return String(name).replace(/[^a-z0-9-_\.]+/gi, '-').replace(/-+/g, '-').replace(/^[-.]+|[-.]+$/g, '');
}

async function main() {
  if (!N8N_URL || !N8N_API_KEY) {
    console.error('Missing N8N_URL or N8N_API_KEY environment variables.');
    return;
  }

  const paths = await tryApiPaths();

  // Ensure output dir exists
  fs.mkdirSync(OUT_DIR, { recursive: true });

  const headers = { 'X-N8N-API-KEY': N8N_API_KEY, 'Content-Type': 'application/json' };

  // Try each candidate API base until successful list call
  let successful = false;
  let chosen;
  for (const p of paths) {
    try {
      const list = await fetchJson(p.list, { headers });
      if (Array.isArray(list)) {
        chosen = p;
        successful = true;
        break;
      }
      // Some n8n versions return an object with data property
      if (list && Array.isArray(list.data)) {
        chosen = p;
        successful = true;
        break;
      }
    } catch (e) {
      // try next
    }
  }

  if (!successful) throw new Error('Failed to list workflows on tried n8n API paths. Check N8N_URL and API key.');

  // Return the chosen API helper to caller
  return { chosen, headers };
}

// Export only the module, do not execute when required.
async function listWorkflows() {
  const res = await main();
  if (!res) return;
  const { chosen, headers } = res;
  const listResponse = await fetchJson(chosen.list, { headers });
  const workflows = Array.isArray(listResponse) ? listResponse : (listResponse.data || []);
  for (const w of workflows) {
    console.log(String(w.id).padEnd(36) + ' ' + String(w.name || ''));
  }
}

async function exportWorkflowById(id) {
  const res = await main();
  if (!res) return;
  const { chosen, headers } = res;
  const workflow = await fetchJson(chosen.get(id), { headers });
  const displayName = workflow.name || id;
  const filename = safeFileName(displayName) || id;
  const outPath = path.join(OUT_DIR, `${filename}-${id}.json`);
  fs.writeFileSync(outPath, JSON.stringify(workflow, null, 2), 'utf8');
  console.log(`Saved ${outPath}`);
}

module.exports = { main, listWorkflows, exportWorkflowById, OUT_DIR };

if (require.main === module) {
  (async () => {
    const argv = process.argv.slice(2);
    if (argv.length === 0) {
      console.log('Usage:');
      console.log('--list                List workflows (id and name)');
      console.log('--export <workflowId> Export workflow JSON to workflows/reference-node-exports/');
      process.exit(0);
    }

    try {
      if (argv[0] === '--list') {
        await listWorkflows();
        process.exit(0);
      }

      if (argv[0] === '--export' && argv[1]) {
        await exportWorkflowById(argv[1]);
        process.exit(0);
      }

      console.error('Unknown command or missing argument. Use --list or --export <id>');
      process.exit(1);
    } catch (e) {
      console.error('Error:', e.message || e);
      process.exit(2);
    }
  })();
}
