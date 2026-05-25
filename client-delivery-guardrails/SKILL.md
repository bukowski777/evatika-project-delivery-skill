---
name: client-delivery-guardrails
description: Use when delivering client software changes that require project orientation, scoped implementation, integration contracts, production-safe release, incident diagnosis, UX review, security/data handling, or operator/client handover across web apps, REST/SOAP APIs, SQL/ERP, Supabase/PostgreSQL, Power Automate, Laravel, containerized services, CI/CD, and sync flows.
---

# Client Delivery Guardrails

## Mission

Ship client software that is understandable, testable, deployable, reversible, secure, and explainable to operators, maintainers, and non-technical decision makers.

Use the language of the user's prompt or current conversation. Do not force French or English.

## When to Use

Use this skill for client delivery work where correctness depends on context, contracts, production safety, user impact, or handover clarity.

Typical triggers:

- project discovery, first release, audit, stabilization, or cautious refactoring;
- SQL/ERP, Supabase/PostgreSQL, REST/SOAP API, webhook, Power Automate, field-service, or sync-flow work;
- Laravel, container, VPS, CI/CD, container registry, release, rollback, or production maintenance;
- incident diagnosis, CPU/latency/stale data/failed jobs, observability, or support escalation;
- dashboard, admin, mobile/tablet, field workflow, labels, copy, or client-facing UX review;
- executive docs, vendor requests, runbooks, delivery reports, incident notes, PDFs, or handover.

## When Not to Use

Do not load the whole skill for trivial edits that are clearly local, low-risk, and unrelated to delivery, production, integrations, documentation, or UX. Use the relevant reference only when it changes the answer.

## Operating Defaults

- Read the project before changing it: `AGENTS.md`, README, deployment docs, changelog, active app path, and local conventions.
- Inspect `git status --short` before editing and distinguish user changes from your changes.
- Separate prototype, target product, production, legacy, demo, fixture, and temporary workaround paths.
- Treat integrations as contracts: stable schemas, payloads, field meanings, auth boundaries, watermarks, and retry semantics.
- Prefer small, scoped changes over broad refactors.
- Keep production changes reversible: backup, health check, smoke check, rollback path, and known deployed version.
- Never put secrets or private client data in code, docs, logs, commits, screenshots, examples, or final reports.
- Verify with tests, probes, screenshots, logs, runtime checks, or explicit static reasoning before claiming success.
- Update local docs when behavior, deployment, configuration, contracts, or operating procedures change.
- Ask before commit, push, destructive operation, migration, or VPS deploy unless the user explicitly requested it in the current task.

## Workflow

1. Orient
   - Identify active product path, production URL, deploy method, data sources, external systems, and user personas.
   - Find existing commands, tests, runbooks, CI workflows, and known temporary workarounds.

2. Classify
   - Type: feature, bug, integration, production incident, UX pass, documentation, deployment, cleanup, security, or handover.
   - Risk: low, medium, or high, based on data mutation, production impact, reversibility, and external dependencies.

3. Map Impact
   - Code paths, data contracts, external systems, deployment/runtime, security, permissions, user-facing copy, and documentation.

4. Choose Route
   - Use existing project patterns first.
   - Prefer contract-compatible changes.
   - Use temporary workarounds only when isolated, documented, observable, and easy to remove.
   - Refuse or pause on irreversible SQL, volume deletion, secret exposure, or destructive infrastructure work without explicit validation and rollback.

5. Implement
   - Keep edits narrow.
   - Preserve local conventions.
   - Add focused regression tests or probes for risky behavior.
   - Do not reintroduce rejected legacy paths.

6. Verify
   - Run targeted tests first, broader checks when risk justifies it.
   - For integrations, verify contract shape, auth boundary, idempotency, failure behavior, and metadata/cache refresh needs.
   - For frontend/UX, inspect desktop plus real tablet/mobile widths.
   - For production paths, verify service state, health endpoint, logs, and one business smoke check.

7. Document
   - Update README, runbook, changelog, ADR, integration contract, or target docs as applicable.
   - For client-facing docs, remove internal reasoning and write for the actual audience.

8. Release or Handover
   - Commit only intended files when commit is requested.
   - Prefer immutable build artifacts or image tags over building on production.
   - After deploy, record deployed version, health result, smoke result, residual risk, and rollback tag/command.

## Evidence Standard

When reporting completion, separate:

- changed files or artifacts;
- verification actually run;
- checks skipped and why;
- remaining risk or pending owner action;
- deploy state, if applicable.

Never imply tests, deployment, screenshots, logs, or production checks were done when they were not.

## Risk Gates

Use a stronger review path when a task touches:

- production data, migrations, destructive SQL, volumes, backups, or retention;
- authentication, authorization, secrets, personal data, exports, or logs;
- integration schemas, watermarks, queues, retries, or external API contracts;
- deploy workflows, registry images, environment variables, worker/scheduler state, or rollback;
- dashboard counts, financial values, operational status, or field workflows used for decisions.

## Reference Router

- New project, unclear scope, missing context, or active path confusion: read `references/project-discovery.md`.
- SQL, ERP, relational databases, workflow automation, REST/SOAP APIs, watermarks, sync flows: read `references/integration-contracts.md`.
- Containers, VPS, CI/CD, container registries, secrets, rollback, release: read `references/production-release.md`.
- Incident, CPU, latency, failed flows, queues, workers, logs, observability: read `references/diagnosis-and-observability.md`.
- Dashboard, mobile/tablet, field workflow, labels, copy, layout: read `references/ux-mobile-review.md`.
- Secrets, personal data, logs, screenshots, exports, data classification, safe examples: read `references/security-and-data-handling.md`.
- Test strategy, verification plan, regression checks, skipped checks: read `references/testing-and-quality-gates.md`.
- Executive docs, vendor requests, runbooks, PDF/handover: read `references/documentation-and-handover.md`.
- Reusable output structure: use `templates/delivery-report.md`, `templates/incident-write-up.md`, `templates/integration-request.md`, `templates/release-plan.md`, or `templates/runbook.md`.

Use specialized skills when relevant and available, especially diagnosis, interface design, TDD, CI, workflow automation, integration, and document/PDF skills. Load only what is needed.

## Completion Checklist

- Worktree inspected.
- Active path and pre-existing changes understood.
- Risk and impact mapped.
- Relevant reference loaded when needed.
- Tests/probes/screenshots/log checks run or explicitly skipped with reason.
- No secrets or private client data added.
- Docs/templates/runbooks updated when behavior or operations changed.
- Commit/deploy scope clear.
- If deployed: immutable tag or SHA known, health OK, smoke check OK, rollback path known.
