# Ploos Identity

Identity-platform configuration and operations for **Ploos AS**. The selected upstream identity provider is [authentik](https://goauthentik.io/). This repository is **not** a custom authentication implementation.

## Status

**Planning only.** No production or beta identity service is deployed by this repository. No real client IDs, secrets, user accounts, DNS records, or live login endpoints are configured.

## Scope

- Shared OpenID Connect (OIDC) identity provider for Ploos Portal and future Ploos services.
- Authentication, account recovery, MFA and passkeys in authentik.
- Tenant membership and service-specific authorization remain in [Ploos Core](https://github.com/Ploos-AS/Ploos-Core).
- Portal browser sessions and OAuth callbacks belong in [Ploos Portal](https://github.com/Ploos-AS/Ploos-Portal).
- Forenio's anonymous/free formation flow must remain usable without a Ploos account.

## Proposed endpoints (not yet active)

| Environment | Identity | Portal |
| --- | --- | --- |
| Beta | `beta.auth.ploos.no` | `beta.account.ploos.no` |
| Production | `auth.ploos.no` | `account.ploos.no` |

## Before deployment

Read [architecture](docs/architecture.md), [deployment preflight](docs/deployment-preflight.md) and [OIDC acceptance tests](docs/oidc-acceptance.md). Install using the **official authentik Compose release**, pin reviewed images by digest, and keep all secrets off Git. Never expose an unconfigured authentik server at a public DNS name.

Upstream references:
- [Official Docker Compose installation](https://docs.goauthentik.io/install-config/install/docker-compose/)
- [OAuth 2.0 / OIDC provider](https://docs.goauthentik.io/add-secure-apps/providers/oauth2/)
- [Backup and restore](https://docs.goauthentik.io/sys-mgmt/ops/backup-restore/)
