# Documentation and Handover

Use this for README, runbooks, executive docs, vendor requests, client PDFs, changelogs, ADRs, session memory, delivery reports, and operational handover.

## Audience Split

- Developer docs: setup, architecture, tests, local commands.
- Operator docs: deploy, rollback, health checks, incidents, backups, secrets.
- Decision-maker docs: purpose, delivered scope, value, risk, roadmap, responsibilities.
- Vendor/service provider docs: exact technical ask, expected contract, validation recipe.
- Field/user docs: workflows, edge cases, screenshots, and support path.

## Document Rules

- Do not mix internal reasoning into client-facing deliverables.
- Make assumptions explicit.
- Use concrete dates and system names.
- Keep reusable runbook commands copy-safe.
- Mention temporary workarounds and removal conditions.
- Update docs alongside significant code/config/deploy changes.
- Mark unknowns instead of inventing operational facts.

## Client-Facing Cleanup

Before sharing externally:

- remove internal chain-of-thought, scratch notes, and speculation;
- replace private hostnames, credentials, IDs, and account names with safe labels;
- convert technical risk into business impact and owner action;
- include only commands the audience is supposed to run;
- separate delivered scope from backlog and recommendations.

## PDF / Client Artifacts

- Reuse the project's standard PDF script and style before creating a new method.
- Verify generated PDF exists, page count, file type, and approximate size.
- Avoid splitting tables, figures, and diagrams across pages where possible.
- Use the client's vocabulary and brand styling.
- Keep source docs versioned when the PDF is a deliverable.

## Delivery Report

Use `templates/delivery-report.md`. Keep final reports short and operational:

- what changed;
- what was verified;
- where it is deployed or stored;
- what remains risky or pending;
- exact next action if one is needed.

## Runbook Handover

Use `templates/runbook.md`. Include only durable procedures:

- access prerequisites;
- normal operation;
- deploy and rollback;
- health checks;
- common incidents;
- escalation path;
- backup/restore ownership;
- observability links or locations without exposing secrets.
