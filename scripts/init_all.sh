#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/.."

# 1) Init top-level submodules
git submodule update --init BlueRetro esp-idf third_party/ogx360

# 2) esp-idf sí requiere recursion (tiene muchos submodules propios)
git -C esp-idf submodule update --init --recursive

# 3) BlueRetro también (tiene liblfds)
git -C BlueRetro submodule update --init --recursive

# 4) ogx360: solo los necesarios para compilar (NO recursive para evitar ejemplos de UHS2)
git -C third_party/ogx360 submodule update --init \
  Firmware/src/lib/ArduinoCore-avr \
  Firmware/src/lib/UHS2

# 5) Por seguridad: desactiva ejemplos de UHS2 si alguien los inicializó antes
UHS2="third_party/ogx360/Firmware/src/lib/UHS2"
for s in \
  examples/testusbhostFAT/Arduino_Makefile_master \
  examples/testusbhostFAT/RTClib \
  examples/testusbhostFAT/generic_storage \
  examples/testusbhostFAT/xmem2
do
  git -C "$UHS2" submodule deinit -f "$s" >/dev/null 2>&1 || true
done
