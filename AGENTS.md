# Repository Agent Instructions

This repository contains the reusable `client-delivery-guardrails` Agent Skill for Codex and Claude Code. When editing it, optimize for clear operational behavior rather than narrative history.

## Editing Rules

- Keep `client-delivery-guardrails/SKILL.md` compact and high-signal.
- Put detailed procedures in `client-delivery-guardrails/references/`.
- Put reusable output structures in `client-delivery-guardrails/templates/`.
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
for script in install.sh scripts/validate-skill.sh scripts/package-skill.sh scripts/test-install.sh; do
  bash -n "$script"
done
./install.sh --dry-run
bash scripts/test-install.sh
```
