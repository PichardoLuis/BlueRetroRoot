#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."
./blueretro_dev.sh
cd BlueRetro
idf.py build
