# Security and Data Handling

Use this for secrets, personal data, logs, screenshots, exports, permissions, data classification, safe examples, and public/client-facing artifacts.

## Data Classification

Classify before copying or summarizing:

- Public: already intentionally public.
- Internal: safe inside the project/team, not public.
- Client confidential: client processes, systems, contracts, private URLs, screenshots, incident details.
- Personal data: names, emails, phone numbers, addresses, logs tied to users, HR/customer data.
- Secrets: credentials, tokens, keys, cookies, certificates, connection strings, `.env` values.

Treat unknown data as confidential until proven otherwise.

## Absolute Rules

- Do not commit secrets, `.env` files, connection strings, private keys, tokens, cookies, or real credentials.
- Do not paste production logs, screenshots, dumps, or external API payloads without redaction.
- Do not include private URLs, IPs, client names, account names, or ticket IDs in reusable skill docs.
- Do not invent secret names or claim a secret exists unless the project docs or environment show it.
- Do not expose internal reasoning in client-facing documents.

## Safe Placeholders

Use placeholders consistently:

```text
<CLIENT_NAME>
<PRODUCTION_URL>
<API_BASE_URL>
<DEPLOY_USER>
<REGISTRY_IMAGE_TAG>
<SECRET_NAME>
<EXTERNAL_SYSTEM>
<WORKFLOW_NAME>
```

## Logs and Screenshots

Before sharing or committing, redact:

- tokens, cookies, authorization headers, passwords, private keys;
- personal data and customer identifiers;
- private hostnames, IPs, URLs, bucket names, and repository names when not public;
- stack traces that include secrets or private paths;
- vendor payloads with business-sensitive fields.

## Permissions

- Prefer least-privilege runtime accounts.
- Document required permissions by action: read, write, execute, deploy, backup, restore.
- Separate human operator permissions from automation/service accounts.
- Confirm whether emergency credentials are break-glass, shared, or per-user.
- Avoid proposing broad admin rights when a narrower role is enough.

## AI-Generated Artifacts

- Keep examples generic.
- Use fake values that cannot be confused with real credentials.
- Mark assumptions and unknowns.
- Avoid creating client-ready claims from unverified code or logs.
- Preserve confidentiality when producing PDFs, reports, screenshots, or handover notes.
