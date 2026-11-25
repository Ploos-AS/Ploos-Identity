# Identity network and TLS policy

Proposed beta hostname: beta.auth.ploos.no. Production auth.ploos.no remains separate. Neither hostname is assumed configured.

Use host Caddy with automatic HTTPS after DNS and ingress approval. The example Caddyfile is not an active configuration. Bootstrap Authentik privately before exposing it. Bind the reviewed upstream Compose HTTP port to 127.0.0.1:9000 only; remove public HTTPS container bindings and never publish PostgreSQL. Verify actual Docker port mappings and external reachability: UFW alone does not reliably restrict Docker-published ports.

Allow inbound TCP 80/443 for approved public ingress, restrict SSH to authorized administration paths, and deny other unsolicited ingress. Preserve existing management access when changing firewall rules. Configure Authentik trusted proxy CIDRs to match the actual Caddy-to-container network path, not arbitrary clients. Do not trust forwarded headers from public clients; review Caddy trusted-proxy settings if an upstream proxy is introduced. Caddy handles WebSocket upgrades through reverse_proxy.

Before activation:
- Validate Caddy configuration with caddy validate using the actual installed configuration.
- Confirm DNS A/AAAA records, certificate issuance and hostname verification.
- Check Docker port bindings and firewall from an independent host.
- Verify OIDC discovery, issuer and callback URLs over HTTPS.
- Verify spoofed forwarded headers do not change security-sensitive origin or client identity.
- Restrict administrative access using reviewed Authentik policies; test operator recovery.
- Avoid logging authorization headers, cookies, tokens or sensitive query strings.
- Test rollback by removing the beta site configuration and reloading Caddy.

No production configuration, DNS changes, firewall changes or live validation are included. Confirm the selected upstream release's proxy requirements before activation.
