# Release Plan

Date: `<YYYY-MM-DD>`
Owner: `<OWNER>`
Environment: `<staging | production>`

## Scope

- `<Change included>`
- `<Change excluded>`

## Artifact

- Repository: `<REPO>`
- Commit/SHA: `<SHA>`
- Image/artifact tag: `<TAG>`

## Pre-Checks

- Worktree/PR state: `<clean/reviewed>`
- CI/local checks: `<result>`
- Secrets/config present: `<yes/no/not touched>`
- Backup needed: `<yes/no>`
- Rollback tag/command known: `<yes/no>`

## Deployment Steps

```bash
<copy-safe deploy command or workflow reference>
```

## Smoke Checks

- `<Health endpoint>`
- `<Business smoke check>`
- `<Logs/service state>`

## Rollback

```bash
<copy-safe rollback command or workflow reference>
```

## Decision Log

- Go/no-go decision: `<DECISION>`
- Approver: `<NAME/ROLE>`
- Notes: `<NOTES>`
