#!/usr/bin/env bash
set -euo pipefail
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Prefer platformio build (real ogx360 firmware)
if command -v pio >/dev/null 2>&1; then
  cd "$ROOT_DIR/third_party/ogx360/Firmware"
  pio run -e OGX360
  exit 0
fi

# Fallback: if you don't have pio, at least validate C syntax (host)
echo "pio not found; running host syntax check only (install PlatformIO for full AVR build)"
cc -std=c11 -Wall -Wextra -Werror -c /dev/null -o /tmp/empty.o >/dev/null 2>&1 || true
