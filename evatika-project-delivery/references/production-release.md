# Production Release

Use this for Docker, VPS, GitHub Actions, GHCR/container registries, secrets, deployments, rollbacks, migrations, and production maintenance.

## Preferred Shape

- CI builds immutable artifacts/images.
- Production pulls a known tag or SHA.
- Production does not build the app unless explicitly accepted.
- `.env` and secrets stay out of Git.
- Deploy scripts are idempotent and print service state.
- Rollback is redeploying the previous known-good tag.
- Operators can see deployed version and deployment time.

## Pre-Deploy Checklist

- Worktree clean or intended changes committed.
- CI passed or local equivalent run.
- Image/artifact tag identified.
- Secrets present only in secret store or target environment.
- Backup plan known for migrations/data changes.
- Rollback tag/command known.
- Maintenance impact understood.
- Health endpoint and business smoke test identified.

## Release Plan

Use `templates/release-plan.md` for non-trivial releases. At minimum, write:

- Scope:
- Environments:
- Artifact/tag/SHA:
- Config/secrets touched:
- Data migration/backfill:
- Pre-checks:
- Deploy command/workflow:
- Smoke checks:
- Rollback command/tag:
- Owner and decision point:

## Docker / VPS Rules

- Avoid `docker compose build` on constrained VPS for production release.
- Use `docker compose pull` then `docker compose up -d --no-build` when images are prebuilt.
- Never run `docker compose down -v` on production data.
- Do not remove containers/volumes/networks unless ownership and impact are verified.
- Keep demo/legacy stacks separate from target production.
- Prefer explicit compose project names when multiple stacks share a host.

## Migrations and Data Changes

- Identify whether the migration is forward-only or rollback-safe.
- Back up before destructive or hard-to-reverse changes.
- Separate schema migration from backfill when possible.
- Keep backfills bounded, observable, resumable, and idempotent.
- Verify row counts and representative business records after migration.

## Laravel Release Notes

- Run migrations deliberately: `php artisan migrate --force`.
- Clear/rebuild caches intentionally: config, route, view, event.
- Ensure storage/log/cache directories are writable.
- Verify scheduler/worker state if present.
- Verify `/health` and at least one business page.

## GitHub Actions

- Manual deployment workflow should require a tag/SHA input.
- Use repository/environment secrets for SSH and registry auth.
- Do not echo secrets.
- Protect main branch when release maturity requires it.
- Prefer deployment environments with approval for production.
- Print enough version/service state to diagnose a failed deploy without leaking secrets.

## No-Go Signals

- Rollback tag unknown.
- Production target ambiguous.
- Secrets missing or copied manually into code/docs.
- Migration touches critical data with no backup plan.
- Health check unavailable for a user-facing production service.
- Worktree contains unrelated edits.

## Post-Deploy

- Record deployed SHA/tag.
- Check container status, health endpoint, logs.
- Execute one functional smoke test.
- Confirm admin observability shows the deployed version.
- Keep previous tag for rollback.
- Summarize residual risk and exact next action, if any.
