# Testing and Quality Gates

Use this for verification plans, regression checks, confidence statements, skipped tests, CI failures, and release readiness.

## Verification Ladder

Choose the smallest evidence that proves the risk is controlled:

1. Static check or type/lint check.
2. Unit or pure function regression test.
3. Integration test with fake/existing fixture data.
4. Local runtime probe.
5. Browser/API/manual smoke check.
6. Staging check.
7. Production health and business smoke check after approved deploy.

Do not jump to broad test suites when a targeted check gives faster signal, but broaden when the change touches shared contracts, deployment, auth, or data.

## Test Selection by Risk

Low risk:

- targeted syntax/type check;
- focused unit test;
- doc/render check for docs-only changes.

Medium risk:

- targeted tests plus related integration/probe;
- representative UI/API smoke check;
- regression around modified contract.

High risk:

- targeted and broader tests;
- backup/rollback check;
- migration/backfill dry run or bounded sample;
- production/staging health criteria;
- explicit owner approval before destructive action.

## What to Verify

- Behavior changed only in intended path.
- Contract shape stayed compatible or downstream changes are coordinated.
- Error, empty, loading, permission-denied, and retry states are sane.
- Logs are useful and do not leak secrets.
- Docs match actual commands/configuration.
- Rollback remains possible.

## Skipped Checks

When a check is skipped, say:

- which check was skipped;
- why it could not be run;
- what weaker evidence was used instead;
- what the user or operator should run next.

Never write "tested" when only a static review was done.

## Completion Language

Use precise wording:

- "Changed" for files edited.
- "Verified" only for checks actually run.
- "Not run" for checks skipped.
- "Risk" for remaining uncertainty.
- "Next" for owner action.
