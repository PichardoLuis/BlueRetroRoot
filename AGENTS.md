# AGENTS.md — BlueRetro (ESP32) + ogx360 (ATmega32U4) SPI bridge

## Goal
Low-latency adapter for Original Xbox:
ESP32-WROOM-32 (BlueRetro) -> SPI -> 2x Pro Micro (ATmega32U4) -> Xbox ports.

## Pins (ESP32 VSPI)
SCK=GPIO18, MOSI=GPIO23, MISO=GPIO19
CS_P1=GPIO16, CS_P2=GPIO17 (recommend 10k pull-ups to 3.3V)
Level shifting via TXB0108.

Critical: On AVR, MISO MUST be high-Z when CS is HIGH (set MISO as INPUT). Only drive MISO while CS is LOW.

## Build commands (must pass)
### ESP32
cd BlueRetroRoot
./blueretro_dev.sh
cd BlueRetro
idf.py build

### AVR
cd third_party/ogx360/Firmware
pio run -e OGX360

## Constraints
- Minimal diffs, no large refactors.
- Fixed-size SPI frames; no heap in hot path / ISR.
- Logging only low-rate outside hot paths.
