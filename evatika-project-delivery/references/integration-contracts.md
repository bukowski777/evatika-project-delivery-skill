# Integration Contracts

Use this for SQL, ERP, Supabase/PostgreSQL, Power Automate, Praxedo, n8n, APIs, webhooks, sync jobs, and watermarks.

## Contract Rules

- Treat SQL views, stored procedures, API payloads, event bodies, and projection tables as contracts.
- Prefer explicit schema/object names and stable column names.
- Avoid `SELECT *` in integration views.
- Stored procedures consumed by automation should return one predictable result set.
- Do not hide business complexity inside an automation flow when a stable SQL/API contract is possible.
- Keep batches small enough for gateway/API limits.
- Make retries idempotent or at least duplicate-safe.

## Watermarks

- Watermarks must be based on technical creation/modification dates, not business/planning dates.
- Never let a future business date advance an incremental sync watermark.
- Store sync state in an operator-visible place with last success, last failure, entity, cursor/watermark, row count, and reason.
- Temporary catch-up jobs must be isolated, documented, observable, and removable.

## SQL / Power Automate

- Use explicit schemas; never assume `dbo`.
- For SQL Server procedures: `SET NOCOUNT ON`, stable columns, one result set, bounded runtime.
- For on-premises gateway constraints, prefer supported connector actions over free-form query execution.
- Document permissions: `SELECT`, `EXECUTE`, schema visibility, gateway/runtime account.
- After SQL object changes, expect metadata/cache refresh steps in the automation platform.

## Supabase / PostgreSQL

- Separate source/projection/read-model tables from app workflow tables.
- Use dedicated least-privilege roles for writers and readers.
- Be explicit about RLS and service-role usage.
- After schema changes, consider PostgREST metadata/cache refresh needs.
- Track data volume and query shape before assuming plan limits are the bottleneck.

## Praxedo / External APIs

- Identify whether the app uses API/REST/SOAP directly, via automation, or through projected data.
- Log external error payloads in a business-readable way without secrets.
- Version sync scripts/workflows when they become operationally important.

## Prestataire Requests

Write requests with:

- exact object names;
- observed symptom;
- root cause hypothesis;
- required change;
- SQL/API contract expected;
- test recipe;
- rollback or safe deployment guidance;
- post-deploy checks.
