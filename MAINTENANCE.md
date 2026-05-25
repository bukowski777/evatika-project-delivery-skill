# Skill Maintenance

## Update the Skill When

- A practice repeats across several client projects.
- A costly mistake could have been prevented by a checklist or gate.
- A fragile procedure deserves a script, reference, or template.
- A vocabulary distinction keeps recurring, such as source of truth, projection, legacy path, demo path, or rollback tag.

## Do Not Update It When

- The case is specific to one client, environment, or incident.
- The addition would expose private infrastructure, secrets, screenshots, IPs, URLs, or ticket history.
- The rule is generic enough to belong in normal engineering habits rather than this skill.
- The procedure should live in a project repository script instead of a reusable skill.

## File Ownership

- `client-delivery-guardrails/SKILL.md`: mission, invocation scope, operating defaults, workflow, gates, and router.
- `client-delivery-guardrails/references/`: detailed operational procedures by domain.
- `client-delivery-guardrails/templates/`: reusable output structures.
- `scripts/`: repository maintenance, validation, and packaging helpers only.
- `install.sh`: local installation helper only.

## Pre-Commit Verification

```bash
bash scripts/validate-skill.sh
./install.sh --dry-run
scripts/package-skill.sh --version test-package
find client-delivery-guardrails -maxdepth 3 -type f | sort
sed -n '1,180p' client-delivery-guardrails/SKILL.md
```

## Review Checklist

- `SKILL.md` stayed compact and did not become a project history.
- New references are linked from the router when relevant.
- Templates contain placeholders, not real client data.
- Install behavior is reversible or dry-run testable.
- Release packaging produces an installable zip without local metadata files.
- CI can validate the package without external services.
- The change improves behavior in future agent runs, not only documentation aesthetics.
