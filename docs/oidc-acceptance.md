# Portal / Core OIDC acceptance checklist

Use a disposable beta-only tenant and test identities; never commit tokens, client secrets or credentials.

## Discovery and authorization

- [ ] Discovery URL `https://beta.auth.ploos.no/application/o/<application-slug>/.well-known/openid-configuration` resolves and issuer matches expected configuration.
- [ ] Portal OAuth Authorization Code + PKCE S256 works with fixed callback allowlist; invalid redirect URIs and plain/absent PKCE are rejected according to configured policy.
- [ ] State mismatch, nonce mismatch, replayed code, invalid signature, wrong audience, expired tokens and wrong issuer are rejected.
- [ ] Session cookies are HttpOnly, Secure, SameSite-appropriate, appropriately scoped and rotated after login; logouts invalidate local sessions.
- [ ] Refresh/revocation and service unavailability fail closed and never leak tokens into client HTML, browser localStorage, logs or error pages.
- [ ] MFA enrollment, second-factor requirement, account recovery, administrator access and session termination are tested.

## Core authorization

- [ ] Determine whether Core validates API access tokens through introspection or JWKS; do not repurpose ID tokens as API credentials.
- [ ] Demonstrate Core recognizes the same issuer and subject, exact audience and scopes.
- [ ] If using introspection, validate provider-scoped confidential client authentication and explicit cross-provider federation where needed.
- [ ] Unauthenticated requests fail; authorized customer A cannot read customer B's organizations or subscriptions.
- [ ] Organization roles and seat limits come from Core, not OIDC group claims.
- [ ] Existing Forenio anonymous routes work without authentication.

## Environment isolation

- [ ] Beta and production use separate issuer, keys, clients, database, cookie names and redirect allowlists.
- [ ] No wildcard redirect URLs, live tokens in test fixtures, or implicit organization creation.
- [ ] Record failure-mode evidence, not just happy-path success.

Official endpoint reference: https://docs.goauthentik.io/add-secure-apps/providers/oauth2/
