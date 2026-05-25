# Security Policy

This repository contains operational guidance for AI-assisted software delivery. It must stay free of sensitive customer data and private infrastructure details.

## Do Not Commit

- API keys, passwords, tokens, SSH keys, certificates, cookies, session values, or `.env` files.
- Client names, private URLs, IP addresses, ticket IDs, screenshots, database dumps, or production logs.
- Real examples containing personal data, financial data, credentials, or proprietary schemas.
- Commands that would be destructive in a specific private environment.

## Safe Examples

Use placeholders such as:

```text
<CLIENT_NAME>
<PRODUCTION_URL>
<DEPLOY_USER>
<REGISTRY_IMAGE_TAG>
<SECRET_NAME>
```

## Reporting Issues

Open a private report to the maintainer when a change could leak sensitive information or cause unsafe agent behavior. Public issues should avoid reproducing secrets or private infrastructure details.
