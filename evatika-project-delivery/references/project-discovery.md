# Project Discovery

Use this when the project, production path, requested change, or active code area is not fully mapped.

## First Pass

- Read `AGENTS.md`, README, deployment docs, changelog, architecture notes, and existing runbooks.
- Locate the active app, legacy/demo/prototype areas, infra files, CI workflows, scripts, docs, fixtures, and generated artifacts.
- Identify production entrypoints: domain, VPS/container, GitHub Actions, cron/scheduler, queues, workers, external automation flows.
- Identify data sources: operational DB, projection/read model, external APIs, files, queues, cache, automation state, and manual imports.
- Identify users and personas: admin, field user, client, back office, operator, manager, service provider.
- Check `git status --short` before editing.
- Identify which files are user changes and do not overwrite them.

## Working Map

Create or keep a short working map:

- Product path:
- Production URL or environment:
- Deployment route:
- Runtime services:
- Data sources:
- External systems:
- Sync mechanisms:
- Critical secrets and where they should live:
- Tests/checks available:
- Known temporary workarounds:
- Known legacy paths to avoid:
- Current worktree changes:

## Questions to Resolve Early

- What is the source of truth for each domain object?
- Is this code path used in production, demo, tests, or documentation only?
- Is the requested change data-contract compatible?
- What breaks if the sync is late, partial, duplicated, or retried?
- Who consumes the output: field user, admin, manager, service provider, operator?
- What is the rollback path?
- What evidence will prove the change works?

## Red Flags

- Same concept named differently across source, projection, UI, and documentation.
- Production still depending on a local developer machine.
- Demo/legacy paths mixed with target app.
- Undocumented workaround that mutates data.
- A dashboard count that does not link to a distinct actionable queue.
- Raw database timestamps, IDs, or source-system terms shown to non-technical users.
- Missing owner for production secrets, backups, scheduler, or gateway runtime account.

## Stop and Clarify

Stop before editing when:

- multiple app roots look plausible;
- a change may touch production data but no rollback is visible;
- a migration, destructive SQL, or volume operation is requested without backup context;
- an integration contract is ambiguous and downstream consumers are unknown.
