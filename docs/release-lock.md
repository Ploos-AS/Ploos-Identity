# Authentik release preparation

Candidate release series: 2026.8 (not approved). Official release notes: https://docs.goauthentik.io/releases/2026.8/

Obtain the official release-series Compose at https://goauthentik.io/version/2026.8/lifecycle/container/compose.yml. This URL may change with patch releases; it is not an immutable lock. Review current security advisories and supported patch releases before selecting the exact patch.

Save original bytes in a protected release directory, record source URL and SHA256, review all services and modify a separate deployment copy. Remove worker Docker socket for manual outpost management, bind ingress to loopback, keep DB private, and review trusted proxy configuration. Preserve upstream required volumes and services.

Record exact patch and all image digests (including PostgreSQL), upstream and modified Compose checksums, platform, reviewer and date. Never use latest or floating tags for deployment. Verify the reviewed copy using bash deploy/verify-compose.sh FILE EXPECTED_SHA256. A checksum protects against changes after review, not upstream authenticity. Validate rendered configuration privately with docker compose config --quiet; verify resolved images and bindings without printing secrets.

No actual lock values are supplied yet. No deployment approval or startup commands. Authentik does not support in-place downgrade; test backup restoration before upgrades.
