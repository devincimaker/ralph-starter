#!/bin/bash
set -e

MAX_ITERATIONS=${1:-10}
SCRIPT_DIR="$(cd "$(dirname \
  "${BASH_SOURCE[0]}")" && pwd)"

echo "🚀 Starting Ralph"

for i in $(seq 1 $MAX_ITERATIONS); do
  echo "═══ Iteration $i ═══"
  
  cat "$SCRIPT_DIR/prompt.md" \
    | claude -p \
      --dangerously-skip-permissions \
      --output-format=stream-json \
      --verbose \
    | npx repomirror visualize || true
  
  sleep 2
done

echo "⚠️ Max iterations reached"
exit 1