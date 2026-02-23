#!/bin/bash
set -euo pipefail

if [ $# -ne 2 ]; then
  echo "Usage: $0 <duration_seconds> <lines_per_second>"
  exit 1
fi

duration=$1
lps=$2
interval=$(awk "BEGIN {printf \"%.4f\", 1/$lps}")

components=("src/core/main.c" "src/net/socket.c" "src/fs/vfs.c" "src/mm/alloc.c" "src/drivers/pci.c"
  "src/crypto/aes.c" "src/sched/cfs.c" "src/ipc/msgqueue.c" "src/block/bio.c" "src/security/lsm.c"
  "lib/string.c" "lib/rbtree.c" "lib/hashtable.c" "arch/x86/boot.S" "arch/x86/entry.S")

actions=("Compiling" "Linking" "Assembling" "Optimizing" "Analyzing")
flags=("-O2 -Wall -Wextra" "-O2 -fPIC" "-O3 -march=native" "-Os -fno-exceptions" "-O2 -g -DDEBUG")
results=("ok" "ok" "ok" "ok" "ok" "ok" "ok" "ok" "ok" "warning: unused variable")

end_time=$((SECONDS + duration))
line=0

echo "=== Build started at $(date) ==="
echo "Configuration: release (parallel=$lps ops/s, duration=${duration}s)"
echo ""

while [ $SECONDS -lt $end_time ]; do
  comp=${components[$((RANDOM % ${#components[@]}))]}
  action=${actions[$((RANDOM % ${#actions[@]}))]}
  flag=${flags[$((RANDOM % ${#flags[@]}))]}
  result=${results[$((RANDOM % ${#results[@]}))]}
  line=$((line + 1))

  printf "[%3d/%3d] %-12s %-30s %s ... %s\n" "$line" "$((duration * lps))" "$action" "$comp" "$flag" "$result"
  sleep "$interval"
done

echo ""
echo "=== Build finished at $(date) ==="
echo "Total: $line objects processed in ${duration}s"
