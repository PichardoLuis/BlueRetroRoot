#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/../third_party/ogx360/Firmware"
pio run -e OGX360
