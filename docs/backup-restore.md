# Identity backup and recovery policy

Proposed retention: 7 daily, 4 weekly, 12 monthly and pre-upgrade snapshots for at least 30 days. Target RPO 24 hours; target RTO 4 hours, subject to measured recovery exercises.

## Backup set

Inventory the reviewed upstream Compose release and every persistent mount. Capture PostgreSQL with a consistent logical dump, required media/files, configuration, custom templates and certificates, signing/encryption material, secret key and database credentials. Coordinate database and file consistency using a reviewed maintenance procedure. Record release digests and checksums in a manifest. Never commit backup contents or credentials.

## Storage

Keep local staging root-only, encrypt before off-host transfer using independently recoverable keys, and verify upload integrity. Use a separate restricted backup account and immutable retention where available. Do not depend on Identity login to access recovery keys or storage. Retention and deletion must respect privacy obligations. Do not prune the last verified recovery point.

## Restore exercise

1. Provision an isolated environment with the recorded compatible release and no production ingress or outbound email.
2. Retrieve and decrypt the backup with independently held recovery credentials; verify checksums.
3. Restore database and required persistent files and secrets using the release-specific upstream procedure.
4. Verify startup, administrative recovery, signing keys, test-account login and OIDC claims. Prevent restored clients from contacting production systems.
5. Record elapsed time, backup age, failures and remediation; securely destroy the exercise environment.

Repeat monthly and before major upgrades. Alert on missing or failed backups, failed uploads, excessive backup age and overdue restore exercises. Mimir should receive status only, never credentials or backup contents.

## Implementation gate

Exact Compose service names, mounts, database version, encryption tooling and remote destination are not yet approved. Implement and test release-specific backup scripts only after these are known. No scheduled backup or restore has been executed.
