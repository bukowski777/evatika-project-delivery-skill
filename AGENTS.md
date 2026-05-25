# Repository Agent Instructions

This repository contains the reusable `evatika-project-delivery` Codex skill. When editing it, optimize for clear operational behavior rather than narrative history.

## Editing Rules

- Keep `evatika-project-delivery/SKILL.md` compact and high-signal.
- Put detailed procedures in `evatika-project-delivery/references/`.
- Put reusable output structures in `evatika-project-delivery/templates/`.
- Do not add client names, private URLs, secrets, screenshots, production credentials, or private infrastructure procedures.
- Prefer checklists, decision gates, and copy-safe commands over long explanations.
- Keep examples generic and anonymized.

## Validation

Run before proposing changes:

```bash
bash scripts/validate-skill.sh
```

For install changes, also run:

```bash
bash -n install.sh scripts/validate-skill.sh
./install.sh --dry-run
```
