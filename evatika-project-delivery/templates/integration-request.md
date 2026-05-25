# Integration Change Request

Recipient: `<VENDOR / SERVICE PROVIDER / INTERNAL TEAM>`
Project: `<PROJECT_NAME>`
Date: `<YYYY-MM-DD>`

## Context

`<What the integration does and why this change is needed.>`

## Observed Symptom

`<Concrete symptom, with safe fake/sample values if needed.>`

## Required Change

- Object/API/procedure/view: `<NAME>`
- Required behavior: `<BEHAVIOR>`
- Stable fields/payload expected: `<FIELDS>`
- Auth/runtime account affected: `<ACCOUNT OR ROLE>`

## Expected Contract

| Field | Type | Meaning | Required | Example |
| --- | --- | --- | --- | --- |
| `<field>` | `<type>` | `<business meaning>` | `<yes/no>` | `<fake value>` |

## Test Recipe

1. `<Step>`
2. `<Step>`
3. `<Expected result>`

## Rollback / Safe Deployment

`<How to deploy safely and revert if needed.>`

## Post-Deploy Checks

- `<Check 1>`
- `<Check 2>`
