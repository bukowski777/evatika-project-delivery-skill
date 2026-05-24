# Documentation and Handover

Use this for README, runbooks, executive docs, vendor requests, client PDFs, changelogs, ADRs, and session memory.

## Audience Split

- Developer docs: setup, architecture, tests, local commands.
- Operator docs: deploy, rollback, health checks, incidents, backups, secrets.
- Decision-maker docs: purpose, delivered scope, value, risk, roadmap, responsibilities.
- Vendor/prestataire docs: exact technical ask, expected contract, validation recipe.

## Document Rules

- Do not mix internal reasoning into client-facing deliverables.
- Make assumptions explicit.
- Use concrete dates and system names.
- Keep reusable runbook commands copy-safe.
- Mention temporary workarounds and removal conditions.
- Update docs alongside significant code/config/deploy changes.

## PDF / Client Artifacts

- Reuse the project's standard PDF script and style before creating a new method.
- Verify generated PDF exists, page count, file type, and approximate size.
- Avoid splitting tables, figures, and diagrams across pages where possible.
- Use the client's vocabulary and brand styling.

## Delivery Report

Keep final reports short and operational:

- what changed;
- what was verified;
- where it is deployed or stored;
- what remains risky or pending;
- exact next action if one is needed.
