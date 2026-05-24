# Production Release

Use this for Docker, VPS, GitHub Actions, GHCR/container registries, secrets, deployments, rollbacks, and production maintenance.

## Preferred Shape

- CI builds immutable artifacts/images.
- Production pulls a known tag or SHA.
- Production does not build the app unless explicitly accepted.
- `.env` and secrets stay out of Git.
- Deploy scripts are idempotent and print service state.
- Rollback is redeploying the previous known-good tag.

## Pre-Deploy Checklist

- Worktree clean or intended changes committed.
- CI passed or local equivalent run.
- Image/artifact tag identified.
- Secrets present only in secret store or target environment.
- Backup plan known for migrations/data changes.
- Rollback tag/command known.
- Maintenance impact understood.

## Docker / VPS Rules

- Avoid `docker compose build` on constrained VPS for production release.
- Use `docker compose pull` then `docker compose up -d --no-build` when images are prebuilt.
- Never run `docker compose down -v` on production data.
- Do not remove containers/volumes/networks unless ownership and impact are verified.
- Keep demo/legacy stacks separate from target production.

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

## Post-Deploy

- Record deployed SHA/tag.
- Check container status, health endpoint, logs.
- Execute one functional smoke test.
- Confirm admin observability shows the deployed version.
- Keep previous tag for rollback.
