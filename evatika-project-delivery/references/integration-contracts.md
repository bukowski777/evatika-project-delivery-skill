# Integration Contracts

Use this for SQL, ERP, Supabase/PostgreSQL, Power Automate, Praxedo, n8n, APIs, webhooks, sync jobs, queues, projections, and watermarks.

## Contract Rules

- Treat SQL views, stored procedures, API payloads, event bodies, projection tables, and CSV/export formats as contracts.
- Prefer explicit schema/object names and stable column names.
- Avoid `SELECT *` in integration views and automation-facing queries.
- Stored procedures consumed by automation should return one predictable result set.
- Do not hide business complexity inside an automation flow when a stable SQL/API contract is possible.
- Keep batches small enough for gateway/API/runtime limits.
- Make retries idempotent or at least duplicate-safe.
- Version important sync scripts, views, procedures, and workflow exports.

## Contract Card

For any integration change, capture:

- Producer:
- Consumer:
- Object/entity:
- Source of truth:
- Contract shape: table/view/procedure/payload/event/file
- Key fields and stable meanings:
- Auth/runtime account:
- Cursor/watermark:
- Idempotency rule:
- Retry behavior:
- Failure visibility:
- Backfill/catch-up plan:
- Rollback or compatibility plan:

## Watermarks

- Base watermarks on technical creation/modification dates, not business/planning dates.
- Never let a future business date advance an incremental sync watermark.
- Store sync state in an operator-visible place with last success, last failure, entity, cursor/watermark, row count, and reason.
- Temporary catch-up jobs must be isolated, documented, observable, and removable.
- Consider clock skew, timezone conversion, null update timestamps, and deleted records.

## SQL / Power Automate

- Use explicit schemas; never assume `dbo`.
- For SQL Server procedures: `SET NOCOUNT ON`, stable columns, one result set, bounded runtime.
- For on-premises gateway constraints, prefer supported connector actions over free-form query execution.
- Document permissions: `SELECT`, `EXECUTE`, schema visibility, gateway/runtime account.
- After SQL object changes, expect metadata/cache refresh steps in the automation platform.
- Verify automation inputs and outputs with a sample record before broad replay.

## Supabase / PostgreSQL

- Separate source/projection/read-model tables from app workflow tables.
- Use dedicated least-privilege roles for writers and readers.
- Be explicit about RLS and service-role usage.
- After schema changes, consider PostgREST metadata/cache refresh needs.
- Track data volume and query shape before assuming plan limits are the bottleneck.
- Validate index usage for polling, dashboard counts, and sync selectors.

## Praxedo / External APIs

- Identify whether the app uses API/REST/SOAP directly, via automation, or through projected data.
- Log external error payloads in a business-readable way without secrets.
- Record rate limits, pagination, retry-after behavior, and payload size limits.
- Preserve external IDs and correlation IDs for diagnosis.
- Version sync scripts/workflows when they become operationally important.

## Failure Modes to Check

- Partial batch success.
- Duplicate records after retry.
- Cursor advanced before durable write.
- Missing delete/cancel propagation.
- External API timeout with unknown commit state.
- Metadata cache stale after schema change.
- Business date used as technical cursor.
- Field renamed in UI but not in integration contract.

## Vendor / Service Provider Request

Use `templates/integration-request.md` and include:

- exact object names;
- observed symptom;
- root cause hypothesis;
- required change;
- expected SQL/API contract;
- sample input/output with fake values;
- test recipe;
- rollback or safe deployment guidance;
- post-deploy checks.
