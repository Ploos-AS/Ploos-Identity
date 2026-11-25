# Mimir monitoring

Inactive examples for the future beta host. Establish a private WireGuard path before scraping internal metrics. Restrict exporter access to Mimir; do not expose metrics or PostgreSQL publicly.

Configure existing Blackbox Exporter with an HTTPS probe module that validates certificates and rejects unexpected redirects. Use job ploos-identity, check=https for the approved beta HTTPS endpoint and check=oidc for the actual application discovery URL. Verify discovery JSON and expected issuer separately; HTTP success alone is insufficient. The example alerts assume exactly one beta target per check; adapt labels and missing-series alerts before adding production.

Scrape host Node Exporter, release-supported Authentik server/worker metrics and a least-privilege PostgreSQL exporter over private networking. Verify release-specific metric names and endpoints before configuring alerts. Track backup success timestamp and restore exercise timestamp using atomic textfile updates; never publish secrets. Alert on stale or missing metrics as well as failures.

Validate rules with promtool check rules monitoring/identity.rules.yml using Mimir's installed Prometheus version. Review target labels, test failure and missing-target alerts, verify notification delivery and recovery before enabling. Suggested scrape interval 30s, timeout 10s. No live changes or tested rules are claimed. Dashboard, backup metrics and private exporter configuration remain follow-up work.
