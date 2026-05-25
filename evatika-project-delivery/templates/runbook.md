# Runbook

System: `<SYSTEM_NAME>`
Owner: `<OWNER>`
Last updated: `<YYYY-MM-DD>`

## Purpose

`<What this system does and who depends on it.>`

## Access Prerequisites

- `<Role/account/tool required>`
- `<Where secrets live, without secret values>`

## Normal Operation

- Start/stop/restart: `<command or workflow>`
- Health check: `<endpoint or command>`
- Logs: `<location or command>`
- Scheduled jobs/workers: `<location and expected cadence>`

## Deployment

```bash
<copy-safe deploy command or workflow reference>
```

## Rollback

```bash
<copy-safe rollback command or workflow reference>
```

## Common Incidents

| Symptom | First checks | Likely owner | Escalation |
| --- | --- | --- | --- |
| `<symptom>` | `<checks>` | `<owner>` | `<path>` |

## Backup / Restore

- Backup owner: `<OWNER>`
- Backup location: `<safe description>`
- Restore procedure: `<reference>`

## Notes and Limits

- `<Known workaround, dependency, or risk>`
