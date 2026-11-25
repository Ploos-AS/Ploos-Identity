#!/bin/bash
set -euo pipefail
# Verify an already reviewed, locally stored Compose artifact.
[[ $# == 2 ]] || { echo 'Usage: verify-compose.sh FILE EXPECTED_SHA256' >&2; exit 2; }
[[ "$2" =~ ^[a-f0-9]{64}$ ]] || exit 2
actual=$(sha256sum -- "$1" | cut -d ' ' -f1)
[[ "$actual" == "$2" ]] || { echo 'Compose checksum mismatch' >&2; exit 1; }
echo 'Compose checksum matches reviewed artifact'
