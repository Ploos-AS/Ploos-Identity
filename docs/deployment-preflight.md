# Deployment preflight (no commands run)

## Environment

1. Select a dedicated host or explicitly approve isolation and capacity on a shared host. For the vendor's Compose install, the official minimum is **2 CPU cores and 2 GB RAM**; allocate additional headroom for PostgreSQL, upgrades and monitoring.
2. Choose beta-first deployment. Reserve public DNS and TLS only once the service is configured and access-controlled. Document network ingress, firewall rules, outbound SMTP, time synchronization and reverse-proxy trust boundaries.
3. Follow the [official authentik Docker Compose guide](https://docs.goauthentik.io/install-config/install/docker-compose/) and record the exact upstream release/Compose source and checksums. Do not handcraft a slim Compose file missing worker/services.
4. Review image versions and pin them to immutable digests before deployment. Verify upgrade path and security advisories before each rollout.
5. Generate fresh random PostgreSQL credentials and `AUTHENTIK_SECRET_KEY` on the host, store with root-only permissions in a secrets manager or protected paths, and exclude from Git, CI logs and backups shared outside the trust boundary.
6. Keep database private, persist all state that upstream requires (including file storage), harden admin setup, and restrict authentik's admin interface to trusted operators.
7. Install HTTPS reverse proxy with strict hostname routing; review trusted proxy headers and avoid open redirects. Validate `/.well-known/openid-configuration`, JWKS, token and introspection endpoint availability to backend callers.
8. Define alerting for TLS validity, public OIDC discovery, worker/server readiness, database and capacity. Do not treat a login-page HTTP 200 alone as a complete health signal.

## Backup and rollback gate

- Before any user onboarding: create encrypted scheduled PostgreSQL backups and backups of required persisted files/configuration/secret key, with off-host retention and restricted restore keys.
- Execute an isolated **restore test** and document its measured result. Preserve the signing and encryption material needed to recover sessions/clients.
- Record an upstream-supported rolling/maintenance upgrade and rollback strategy; restoring a database across incompatible schema versions must not be assumed safe.
- Prepare a tested administrator recovery method and documented incident-response contact.

## Release gates

- [ ] Hosting and threat model approved
- [ ] Upstream Compose version, checksums, image digests and license reviewed
- [ ] Network and HTTPS checks passed
- [ ] Backup, restore and rollback rehearsed
- [ ] Identity security policy approved
- [ ] OIDC integration tests passed against Ploos Portal and Ploos Core
- [ ] Monitoring and incident response enabled
- [ ] Explicit approval to enable beta sign-ins

**Do not deploy** from this documentation alone.
