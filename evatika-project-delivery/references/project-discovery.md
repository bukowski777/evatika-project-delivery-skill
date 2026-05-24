# Project Discovery

Use this when the project, production path, or requested change is not fully mapped.

## First Pass

- Read `AGENTS.md`, `README.md`, deployment docs, and changelog.
- Locate the active app, legacy/demo areas, infra files, CI workflows, scripts, and docs.
- Identify production entrypoints: domain, VPS/container, GitHub Actions, cron/scheduler, queues, workers.
- Identify data sources: operational DB, projection/read model, external APIs, files, queues, automation flows.
- Identify users and personas: admin, field user, client, back office, operator, manager.
- Check `git status --short` before editing.

## Map to Build

Create a short working map:

- Product path:
- Production URL:
- Deployment route:
- Runtime services:
- Data sources:
- External systems:
- Sync mechanisms:
- Critical secrets and where they should live:
- Tests/checks available:
- Known temporary workarounds:
- Known legacy paths to avoid:

## Questions to Resolve Early

- What is the source of truth for each domain object?
- Is this code path used in production, demo, or only documentation?
- Is the change data-contract compatible?
- What breaks if the sync is late, partial, duplicated, or retried?
- Who consumes the output: field user, admin, manager, prestataire, operator?
- What is the rollback path?

## Red Flags

- Same concept named differently in several places.
- Production still depending on a local developer machine.
- Demo/legacy paths mixed with target app.
- Undocumented workaround that changes data.
- A dashboard count that does not link to a distinct actionable queue.
- Date/time values shown raw from storage.
