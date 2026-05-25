# Evatika Project Delivery Skill

[![Validate skill](https://github.com/bukowski777/evatika-project-delivery-skill/actions/workflows/validate.yml/badge.svg)](https://github.com/bukowski777/evatika-project-delivery-skill/actions/workflows/validate.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

Reusable Codex skill for delivering client software safely.

It helps an agent orient itself in a project, keep changes scoped, treat integrations as contracts, verify production-sensitive work, and produce useful handover notes.

This repository intentionally contains no client data, secrets, private production configuration, screenshots, or private infrastructure procedures.

## Why It Exists

Most AI-assisted coding examples focus on writing code. Client delivery also needs context, rollback paths, observability, security, documentation, and clear ownership.

This skill captures those habits in a reusable Codex workflow for freelancers, agencies, and small teams shipping real client projects.

## Use It For

- project discovery, audit, stabilization, or first release;
- cautious implementation or refactoring;
- SQL, ERP, API, webhook, Supabase/PostgreSQL, Power Automate, Praxedo, n8n, or sync-flow work;
- Docker, VPS, GitHub Actions, GHCR, deployment, rollback, or production maintenance;
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

From the repository root:

```bash
./install.sh
```

The installer copies `evatika-project-delivery/` into:

```text
~/.codex/skills/evatika-project-delivery
```

If a previous local install exists, it is backed up before replacement.

Useful options:

```bash
./install.sh --dry-run
SKILL_TARGET_DIR="$HOME/.codex/skills/evatika-project-delivery" ./install.sh
```

## Use In Codex

Ask explicitly:

```text
Use $evatika-project-delivery for this task.
```

Examples:

```text
Use $evatika-project-delivery to audit this production deploy flow and propose a rollback-safe release plan.
```

```text
Use $evatika-project-delivery to diagnose why this Power Automate sync is stale without changing production data.
```

```text
Use $evatika-project-delivery to review the tablet UX and produce a client-ready delivery report.
```

## Included

| Path | Purpose |
| --- | --- |
| `evatika-project-delivery/SKILL.md` | Main skill, workflow, risk gates, and reference router. |
| `evatika-project-delivery/references/` | Detailed guidance for discovery, integrations, release, diagnosis, UX, security, testing, and handover. |
| `evatika-project-delivery/templates/` | Reusable report, incident, integration request, release plan, and runbook structures. |
| `scripts/validate-skill.sh` | Local package validation and obvious secret-pattern checks. |
| `scripts/package-skill.sh` | Builds a release zip containing the installable skill directory. |
| `.github/workflows/validate.yml` | GitHub Actions validation on push and pull request. |
| `.github/workflows/release.yml` | GitHub Actions release packaging on `v*` tags. |
| `install.sh` | Local installer with dry-run, backup, and configurable target directory. |

## Validate

Run before committing or distributing changes:

```bash
bash scripts/validate-skill.sh
./install.sh --dry-run
```

The validation script checks required files, `SKILL.md` frontmatter, router links, shell syntax, package size, metadata files, and obvious secret-like patterns.

## Package

Build a local release archive:

```bash
scripts/package-skill.sh --version v0.1.0
```

The archive is written to `dist/` and contains the installable `evatika-project-delivery/` skill directory.

To publish a GitHub release, push a version tag:

```bash
git tag v0.1.0
git push origin v0.1.0
```

The `Release package` workflow validates the skill, creates the zip, and attaches it to the GitHub release for that tag.

## Public Safety Rules

Do not add:

- client names, private URLs, IPs, account names, ticket IDs, screenshots, production logs, or database dumps;
- API keys, tokens, passwords, SSH keys, certificates, cookies, session values, or `.env` files;
- real examples containing personal data, financial data, credentials, proprietary schemas, or private infrastructure commands.

Use placeholders such as `<CLIENT_NAME>`, `<PRODUCTION_URL>`, `<SECRET_NAME>`, and `<REGISTRY_IMAGE_TAG>`.

## Contributing

Good additions are reusable checklists, routing rules, templates, validation checks, or delivery gates that prevent repeated mistakes.

Avoid project diary entries, client-specific incident history, broad essays, or rules that belong in a specific project repository.

See `CONTRIBUTING.md`, `SECURITY.md`, and `MAINTENANCE.md`.

## License

MIT. See `LICENSE`.
