# Pilot installation layout

Proposed dedicated host: heimdall.ousdal.net (not provisioned).
Use Debian 13, Docker Compose, Caddy and UFW. Suggested capacity: 4 vCPU, 4–8 GiB RAM and 50 GiB disk.

Proposed paths:
- /etc/ploos-apps/ploos-identity/compose.yaml
- /etc/ploos-apps/ploos-identity/.env (root-only 0600)
- /srv/ploos-apps/ploos-identity/releases/
- /srv/ploos-apps/ploos-identity/data/

Run bash deploy/preflight.sh on the candidate host with an authorized Docker operator. The script only checks basic local prerequisites; it does not install or change anything. Its memory threshold allows for OS-reserved RAM and its disk threshold is only a basic free-space check, not a capacity guarantee.

Select a supported upstream Authentik release, obtain its official Compose file, review all services, volumes and privileges, pin images by digest, and validate with docker compose config --quiet. Keep the upstream file and checksum in the release directory. Review release-specific environment variables before generating secrets. Bind web ingress to loopback behind Caddy and do not publish database ports. Do not mount the Docker socket unless an explicitly reviewed requirement justifies it.

No Compose file is approved yet. Do not run compose up until host, release, secrets and network policy have been reviewed. Beta and production must have independent state and credentials.
