---
name: evatika-project-delivery
description: Use when developing, auditing, stabilizing, deploying, documenting, or preparing first release for client software projects with web apps, APIs, Docker, VPS, GitHub Actions, Supabase/PostgreSQL, SQL/ERP, Power Automate, Praxedo, n8n, sync flows, UX review, production incidents, security, or handover work.
---

# Evatika Project Delivery

## Mission

Ship client software that is understandable, testable, deployable, reversible, secure, and explainable to both operators and non-technical decision makers.

Use the language of the user's prompt or current conversation. Do not force French or English.

## Operating Defaults

- Read the project before changing it: README, AGENTS, deployment docs, changelog, and active app path.
- Separate prototype, target product, production, legacy, demo, and temporary workaround.
- Treat integrations as contracts: stable schemas, stable payloads, stable field meanings.
- Keep production changes reversible: backup, health check, smoke check, rollback path.
- Never put secrets in code, docs, logs, commits, screenshots, or examples with real values.
- Prefer small, scoped changes over broad refactors.
- Verify with tests, probes, screenshots, logs, or runtime checks before claiming success.
- Update local docs when behavior, deployment, configuration, or operating procedure changes.
- Ask before commit, push, or VPS deploy unless the user explicitly requested it in the current task.

## Workflow

1. Orient
   - Identify the active product path, production URL, deploy method, data sources, and user personas.
   - Inspect `git status --short` and distinguish current work from pre-existing changes.

2. Classify
   - Feature, bug, integration, production incident, UX pass, documentation, deployment, cleanup, security.
   - Mark risk: low, medium, high.

3. Map Impact
   - Code paths, data contracts, external systems, deployment/runtime, user-facing copy/UX.

4. Choose Route
   - Existing patterns first.
   - Contract-compatible changes first.
   - Temporary workaround only if isolated, documented, observable, and easy to remove.
   - No destructive SQL, volume deletion, or irreversible infrastructure operation without explicit validation and rollback.

5. Implement
   - Keep edits narrow.
   - Add focused regression tests or probes for risky behavior.
   - Preserve local conventions.
   - Do not reintroduce rejected legacy paths.

6. Verify
   - Run targeted tests first, broader checks when risk justifies it.
   - For frontend/UX, inspect desktop and mobile/tablet.
   - For production paths, verify service state, health endpoint, logs, and a business smoke check.

7. Document
   - Update runbooks, README, changelog, ADR, or target docs as applicable.
   - For client-facing docs, remove internal reasoning and write for the audience.

8. Release
   - Commit only intended files.
   - Prefer immutable build artifacts or image tags over building on production.
   - After deploy, record the deployed version, health result, and rollback tag.

## Reference Router

- New project, unclear scope, or missing context: read `references/project-discovery.md`.
- SQL, ERP, Supabase, Power Automate, Praxedo, n8n, APIs, watermarks, sync flows: read `references/integration-contracts.md`.
- Docker, VPS, GitHub Actions, GHCR, secrets, rollback, release: read `references/production-release.md`.
- Incident, CPU, latency, failed flows, queues, workers, logs, observability: read `references/diagnosis-and-observability.md`.
- Dashboard, mobile/tablet, field workflow, labels, copy, layout: read `references/ux-mobile-review.md`.
- Executive docs, vendor requests, runbooks, PDF/handover: read `references/documentation-and-handover.md`.

Use specialized skills when relevant and available, especially diagnosis, interface design, TDD, GitHub/CI, Power Automate, n8n, and document/PDF skills. Load only what is needed.

## Completion Checklist

- Worktree inspected.
- Risk and impact understood.
- Relevant tests/probes run or explicitly skipped with reason.
- No secrets added.
- Docs updated when needed.
- Commit/deploy scope clear.
- If deployed: immutable tag or version known, health OK, smoke check OK, rollback path known.
