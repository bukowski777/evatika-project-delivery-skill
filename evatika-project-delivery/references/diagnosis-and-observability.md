# Diagnosis and Observability

Use this for incidents, latency, CPU saturation, failing jobs, stale sync, empty dashboards, and unexplained production behavior.

## Diagnosis Loop

1. Reproduce or observe the symptom.
2. Bound the timeframe.
3. Compare app metrics, container metrics, OS metrics, external platform graphs, and logs.
4. Identify the smallest component that changed.
5. Form one hypothesis at a time.
6. Test with a reversible probe.
7. Fix the root cause or isolate a safe workaround.
8. Add observability so the issue is visible next time.

## Common Axes

- CPU: user/system/iowait/steal, sustained vs spike.
- Memory: RSS, swap, OOM, leaks.
- I/O: disk pressure, logs, database, backups.
- Network: gateway, external API, DNS, TLS, rate limit.
- Workers: queues, task runners, scheduler cadence, stuck jobs.
- Cache: stale cache, missing invalidation, cold cache, expensive recompute.
- Data: watermark ahead, missing update timestamp, duplicate keys, null joins.

## VPS / Container Probes

- `docker stats`
- `docker compose ps`
- `docker compose logs --tail`
- `top` or `htop`
- `vmstat 1`
- `df -h`
- `du -sh`
- service-specific health endpoints

Use the project's existing deployment/runbook commands before inventing new ones.

## Admin Observability Targets

Expose enough for operations:

- deployed version and deployment time;
- sync last success/failure by entity;
- alert count and latest error;
- cache freshness;
- catch-up/watermark job status;
- active users / recent failed logins;
- stack versions and dependency alerts;
- last updated business object when relevant.

## Incident Write-Up

Capture:

- symptom;
- timeframe;
- impacted users;
- measured cause;
- direct fix;
- residual risk;
- prevention/monitoring added;
- rollback or emergency command if it returns.
