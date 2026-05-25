# Contributing

This repository is a reusable operational skill, not a project diary. Add only guidance that is safe, repeatable, and useful across multiple client projects.

## Good Additions

- A checklist that would have prevented a repeated delivery mistake.
- A routing rule that helps Codex load the right reference at the right time.
- A generic template for reports, runbooks, incidents, releases, or vendor requests.
- A validation script that reduces packaging or maintenance risk.

## Avoid

- Client-specific implementation history.
- Private domains, IPs, secrets, account names, screenshots, ticket IDs, or production commands tied to one environment.
- Long essays in `SKILL.md`.
- Broad rules already covered by common engineering practice unless they are essential delivery gates.

## Local Checks

```bash
bash scripts/validate-skill.sh
./install.sh --dry-run
```

A change is ready when the skill remains compact, references exist, validation passes, and no sensitive information has been introduced.
