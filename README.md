# Evatika Project Delivery Skill

Codex skill for scoping, building, diagnosing, deploying, and documenting Evatika client projects with production-grade rigor.

The skill is intentionally generic but technical. It formalizes reusable practices learned from real client projects: SQL/API/Power Automate/Supabase integrations, Docker/GitHub Actions/VPS deployment, production incidents, observability, field UX, and executive/vendor documentation.

This repository does not contain client data, secrets, production configuration, or procedures tied to private infrastructure. Examples stay at the level of practices and checklists.

## Why This Exists

Most AI-assisted coding examples focus on implementing a feature. Client delivery also needs production safety: scoped changes, integration contracts, rollback paths, observability, operator handover, and clear documentation. This skill captures those delivery habits in a reusable Codex workflow.

## Contents

```text
evatika-project-delivery/
  SKILL.md
  agents/openai.yaml
  references/
    project-discovery.md
    integration-contracts.md
    production-release.md
    diagnosis-and-observability.md
    ux-mobile-review.md
    documentation-and-handover.md
```

## Local Installation

From the repository root:

```bash
./install.sh
```

The script copies the `evatika-project-delivery` directory into:

```text
~/.codex/skills/evatika-project-delivery
```

If the target directory already exists, it is replaced with the repository version.

## Usage

In Codex, ask explicitly:

```text
Use $evatika-project-delivery for this task.
```

The skill can also be triggered implicitly for tasks such as:

- client project development;
- cautious audit or refactoring;
- SQL/API/Power Automate/Supabase integration;
- Docker/VPS/GitHub Actions deployment;
- production incident, CPU, latency, or sync diagnosis;
- mobile/tablet UX review;
- executive, vendor, or runbook documentation.

## Principles

- Read the project before changing it.
- Separate prototype, target product, production, legacy, and temporary workaround.
- Treat integrations as contracts.
- Never expose secrets.
- Verify before declaring the work complete.
- Document decisions and procedures.
- Deploy with a known rollback path.

## Maintenance

Keep the skill short and actionable:

- `SKILL.md` contains the invariants and the router to references;
- details live in `references/`;
- add scripts only when a procedure is repeated across several projects;
- avoid turning the skill into a project history.

## License

This project is published under the MIT license. See `LICENSE`.
