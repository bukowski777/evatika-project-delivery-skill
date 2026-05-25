# Evatika Project Delivery Skill

Reusable Codex skill for delivering client software safely: scoping, implementation, integration contracts, deployment, diagnosis, UX review, security, and handover.

The skill captures reusable delivery practices from technical client projects involving SQL/API/Power Automate/Supabase integrations, Docker/GitHub Actions/VPS deployment, production incidents, observability, field UX, and executive/vendor documentation.

This repository intentionally contains no client data, secrets, private production configuration, screenshots, or procedures tied to private infrastructure.

## When to Use

Use the skill when a task needs more than a code edit:

- project discovery or unclear production path;
- cautious implementation or refactoring;
- SQL, ERP, Supabase/PostgreSQL, API, webhook, Power Automate, Praxedo, n8n, or sync-flow work;
- Docker, VPS, GitHub Actions, GHCR, release, rollback, or production-maintenance work;
- production incident diagnosis, latency/CPU issues, stale data, failed queues, or missing observability;
- dashboard, mobile/tablet, admin, or field UX review;
- executive/client/vendor documentation, handover, runbook, incident note, or release report.

## What It Enforces

- Read the project before changing it.
- Separate production, target product, prototype, demo, legacy, and workaround paths.
- Treat integration schemas, payloads, watermarks, and projected tables as contracts.
- Keep production changes reversible with backup, health check, smoke check, and rollback path.
- Never add secrets or private client data to code, docs, logs, screenshots, or examples.
- Verify with tests, probes, screenshots, logs, or runtime checks before claiming completion.
- Document operational changes where future maintainers will actually look.

## Repository Layout

```text
.
|-- AGENTS.md
|-- CHANGELOG.md
|-- CONTRIBUTING.md
|-- MAINTENANCE.md
|-- SECURITY.md
|-- install.sh
|-- scripts/
|   `-- validate-skill.sh
`-- evatika-project-delivery/
    |-- SKILL.md
    |-- agents/
    |   `-- openai.yaml
    |-- references/
    |   |-- diagnosis-and-observability.md
    |   |-- documentation-and-handover.md
    |   |-- integration-contracts.md
    |   |-- production-release.md
    |   |-- project-discovery.md
    |   |-- security-and-data-handling.md
    |   |-- testing-and-quality-gates.md
    |   `-- ux-mobile-review.md
    `-- templates/
        |-- delivery-report.md
        |-- incident-write-up.md
        |-- integration-request.md
        |-- release-plan.md
        `-- runbook.md
```

## Local Installation

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

## Validation

Run the repository checks before committing or distributing the skill:

```bash
bash scripts/validate-skill.sh
```

The validation script checks required files, `SKILL.md` frontmatter, router links, shell syntax, and obvious secret patterns.

## Usage

In Codex, ask explicitly:

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

## Maintenance Rules

Keep the skill short and actionable:

- `SKILL.md` contains invariants, workflow, gates, and the reference router;
- detailed procedures live in `references/`;
- reusable output shapes live in `templates/`;
- scripts exist only for repeated repository-level maintenance;
- never turn the skill into a private project history.

## License

MIT. See `LICENSE`.
