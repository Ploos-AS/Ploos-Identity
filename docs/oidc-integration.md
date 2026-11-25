# OIDC integration contract

Proposed beta application slug: ploos-portal-beta. Proposed discovery URL: https://beta.auth.ploos.no/application/o/ploos-portal-beta/.well-known/openid-configuration. Discover and verify the exact issuer; do not infer it from the hostname. Proposed exact redirect URI: https://beta.account.ploos.no/auth/callback (Portal route not implemented).

Portal is a confidential server-side client using authorization code with PKCE S256, state and nonce. Verify ID token signature, issuer, audience, expiry and nonce. Store tokens server-side; browser receives only an opaque Secure HttpOnly SameSite session cookie. Protect state-changing routes against CSRF. Use short-lived sessions and rotate session identifiers at login. Verify logout and revocation behavior.

Core uses verified access tokens only, not ID tokens. Existing Core introspection contract requires active, iss, sub, aud, exp and Bearer token type. Test Authentik's actual introspection response and resource audience before enabling Core portal routes. If incompatible, implement a reviewed access-token verifier or provider configuration; never weaken claim checks or assume the Portal client ID is a valid Core resource audience. Keep Core private and use authenticated TLS for Portal-to-Core traffic.

Identity key is exact verified issuer plus subject. Core owns enrollment and tenant memberships; no automatic grants from email, domain or provider groups. Unknown users fail closed. Beta and production use independent clients, secrets, state and issuer mappings. Forenio's free anonymous workflow remains independent.

## Acceptance gates

- Confirm discovery, exact redirect and issuer, supported signing algorithms and key rotation.
- Test invalid state, nonce, PKCE, signature, issuer, audience, expired and revoked tokens.
- Reject ID tokens at Core API and verify access-token-only introspection.
- Verify unknown identities, cross-tenant access and revoked membership are denied.
- Test logout, session expiry, recovery and operator MFA.
- Keep self-registration, organization creation, orders and provisioning disabled during initial pilot.

No provider configuration or application code is changed by this contract. The actual Authentik release and token compatibility must be verified in an isolated beta environment before integration is enabled.
