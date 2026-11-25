#!/bin/bash
set -euo pipefail
fail=0
check() {
  if "$@"; then printf 'PASS: %s\n' "$*"; else printf 'FAIL: %s\n' "$*"; fail=1; fi
}
check command -v docker
check docker compose version
check test "$(nproc)" -ge 2
check test "$(awk '/^MemTotal:/ {print $2}' /proc/meminfo)" -ge 1800000
check test "$(df -Pk / | awk 'NR==2 {print $4}')" -ge 10485760
printf '\nHost: %s\n' "$(hostname)"
free -h
df -h /
printf '\nReview firewall, TLS, backup storage and upstream release separately.\n'
exit "$fail"
