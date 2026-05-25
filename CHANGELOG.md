# Changelog

All notable changes to this skill repository should be documented here.

## Unreleased

## v0.3.1 - 2026-05-25

- Aligned the default Codex install target with the official Codex user skills path, `~/.agents/skills`.
- Added `codex-legacy` as an explicit target for older local setups using `~/.codex/skills`.
- Added an install smoke test covering Codex, Claude Code, legacy backup, and metadata stripping.
- Expanded validation to required repository files, full tracked-file secret scanning, skill name/description quality gates, and optional ShellCheck.
- Hardened release packaging with option validation, zip inspection, metadata checks, and `.sha256` checksum generation.
- Updated CI to run ShellCheck, repository validation, install smoke tests, and package smoke tests.
- Added `.gitattributes` for consistent text and binary handling.

## v0.3.0 - 2026-05-25

- Renamed the public skill identity to `client-delivery-guardrails` to avoid collisions with existing public skills.
- Kept the name function-oriented after removing the earlier company-oriented identity.
- Added Claude Code and shared-agent installation targets through `install.sh --target`.
- Added automatic local backup of the previous `client-delivery` install folder during installation.
- Added optional legacy install backup for previous-name local copies.
- Expanded the delivery report template with source artifacts, phase-level effort summary, and an optional diagram slot.
- Replaced client-context product examples with generic technical categories such as REST/SOAP APIs, ERP, workflow automation, relational databases, containers, and CI/CD.
- Tightened README positioning and restored concrete technical examples such as SQL Server, PostgreSQL, Supabase, Power Automate, and Laravel.
- Hardened installation with dry-run support, backup-before-replace, and configurable target directory.
- Added validation script and CI workflow for skill structure, frontmatter, router links, shell syntax, and obvious secret patterns.
- Added security/data-handling and testing/quality-gate references.
- Added reusable delivery, incident, integration request, release plan, and runbook templates.
- Added repository agent instructions, contribution guidance, and maintenance checklist updates.
- Kept validation compatible with macOS Bash 3.2.
- Excluded local metadata files from validation and installation output.
- Revised README for public repository presentation and clearer onboarding.
- Added release zip packaging script and hosted release workflow for `v*` tags.
