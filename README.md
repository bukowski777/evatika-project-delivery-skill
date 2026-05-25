# Client Delivery Guardrails Skill

[![Validate skill](https://github.com/bukowski777/client-delivery-guardrails-skill/actions/workflows/validate.yml/badge.svg)](https://github.com/bukowski777/client-delivery-guardrails-skill/actions/workflows/validate.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Reusable Agent Skill for delivery guardrails in Codex and Claude Code.

It helps an agent orient itself in a project, keep changes scoped, treat integrations as contracts, verify production-sensitive work, and produce useful handover notes.

## Why It Exists

Most AI-assisted coding examples focus on writing code. Client delivery also needs context, rollback paths, observability, security, documentation, and clear ownership.

This skill captures those habits in a reusable agent workflow for freelancers, agencies, and small teams shipping real client projects.

## Use It For

- project discovery, audit, stabilization, or first release;
- cautious implementation or refactoring;
- SQL Server/PostgreSQL/Supabase, ERP, REST/SOAP API, webhook, Power Automate, or sync-flow work;
- Laravel, container, VPS, CI/CD, container registry, deployment, rollback, or production maintenance;
- incident diagnosis, stale data, latency, CPU, queues, workers, or missing observability;
- dashboard, admin, tablet, mobile, or field UX review;
- executive, client, vendor, runbook, incident, release, or handover documentation.

## What It Enforces

- Read the project before changing it.
- Separate production, target product, prototype, demo, legacy, fixture, and workaround paths.
- Treat schemas, payloads, watermarks, projected tables, and external APIs as contracts.
- Keep production changes reversible with backup, health check, smoke check, and rollback path.
- Never add secrets or private client data to code, docs, logs, screenshots, examples, or final reports.
- Verify with the smallest meaningful evidence before claiming completion.
- Document operational changes where future maintainers will actually look.

## Install

From the repository root, install for Codex user skills:

```bash
./install.sh
```

Install for Claude Code:

```bash
./install.sh --target claude-code
```

Install across Codex and Claude Code:

```bash
./install.sh --target all
```

Target paths:

```text
~/.agents/skills/client-delivery-guardrails      # Codex user skills
~/.claude/skills/client-delivery-guardrails      # Claude Code personal skills
~/.codex/skills/client-delivery-guardrails       # legacy/local fallback only
```

If a previous local install exists, it is backed up before replacement. The installer also backs up the earlier `client-delivery` folder when it exists in the same target root, so old and new skill names do not stay active side by side.

Claude Code installs omit the Codex-specific `agents/openai.yaml` metadata file. The source package still keeps it for Codex compatibility.

For current Codex versions, prefer `~/.agents/skills`. Use the legacy fallback only when a local Codex setup still scans `~/.codex/skills`:

```bash
./install.sh --target codex-legacy
```

Useful options:

```bash
./install.sh --dry-run
SKILL_TARGET_DIR="$HOME/.agents/skills/client-delivery-guardrails" ./install.sh
```

## Use In Codex And Claude Code

In Codex, ask explicitly:

```text
Use $client-delivery-guardrails for this task.
```

In Claude Code, invoke it directly:

```text
/client-delivery-guardrails
```

Examples:

```text
Use $client-delivery-guardrails to audit this production deploy flow and propose a rollback-safe release plan.
```

```text
Use $client-delivery-guardrails to diagnose why this Power Automate sync from SQL Server to Supabase is stale without changing production data.
```

```text
Use $client-delivery-guardrails to prepare a Laravel release plan with migrations, smoke checks, and rollback steps.
```

```text
Use $client-delivery-guardrails to review the tablet UX and produce a client-ready delivery report.
```

## Included

| Path | Purpose |
| --- | --- |
| `client-delivery-guardrails/SKILL.md` | Main skill, workflow, risk gates, and reference router. |
| `client-delivery-guardrails/references/` | Detailed guidance for discovery, integrations, release, diagnosis, UX, security, testing, and handover. |
| `client-delivery-guardrails/templates/` | Reusable report, incident, integration request, release plan, and runbook structures. |
| `scripts/validate-skill.sh` | Local package validation and obvious secret-pattern checks. |
| `scripts/package-skill.sh` | Builds a release zip containing the installable skill directory. |
| `.github/workflows/validate.yml` | CI validation on push and pull request. |
| `.github/workflows/release.yml` | Release packaging on `v*` tags. |
| `install.sh` | Local installer with Codex, Claude Code, shared-agents, dry-run, backup, and configurable target support. |

## Validate

Run before committing or distributing changes:

```bash
bash scripts/validate-skill.sh
./install.sh --dry-run
bash scripts/test-install.sh
```

The validation script checks required files, `SKILL.md` frontmatter, router links, shell syntax, optional shell lint, package size, metadata files, and obvious secret-like patterns across tracked text files.

## Package

Build a local release archive:

```bash
scripts/package-skill.sh --version v0.3.1
```

The archive is written to `dist/` and contains the installable `client-delivery-guardrails/` skill directory. A matching `.sha256` checksum is created next to the zip.

To publish a hosted release, push a version tag:

```bash
git tag v0.3.1
git push origin v0.3.1
```

The `Release package` workflow validates the skill, creates the zip, and attaches it to the hosted release for that tag.

## Public Safety Rules

Do not add:

- client names, private URLs, IPs, account names, ticket IDs, vendor/product names from private client contexts, screenshots, production logs, or database dumps;
- API keys, tokens, passwords, SSH keys, certificates, cookies, session values, or `.env` files;
- real examples containing personal data, financial data, credentials, proprietary schemas, or private infrastructure commands.

Use placeholders such as `<CLIENT_NAME>`, `<PRODUCTION_URL>`, `<SECRET_NAME>`, and `<REGISTRY_IMAGE_TAG>`.

## Contributing

Good additions are reusable checklists, routing rules, templates, validation checks, or delivery gates that prevent repeated mistakes.

Avoid project diary entries, client-specific incident history, broad essays, or rules that belong in a specific project repository.

See `CONTRIBUTING.md`, `SECURITY.md`, and `MAINTENANCE.md`.

## License

MIT. See `LICENSE`.
