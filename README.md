# HomeAutomation

A collection of home automation scripts focused on practical, local-first utility tasks.

Right now this repo includes a **Home Assistant** folder with sunrise and sunset calculation tools in both **PowerShell** and **Python**, plus a simple equation reference file. The repository is currently public, MIT licensed, and primarily uses PowerShell and Python. :contentReference[oaicite:0]{index=0}

## Current Contents

### Home Assistant
- `Get-SunriseSunset.ps1`
- `sunrise_sunset.py`
- `SunriseSunsetEquation.txt` :contentReference[oaicite:1]{index=1}

## What These Scripts Do

These scripts calculate **sunrise** and **sunset** times for a specific date using:
- exact GPS coordinates
- a local time zone
- standard solar event calculations through the Python `astral` library :contentReference[oaicite:2]{index=2}

This is useful for:
- Home Assistant automations
- outdoor lighting schedules
- astronomy planning
- solar-related triggers
- general location-based time events :contentReference[oaicite:3]{index=3}

## Requirements

### Python
- Python 3.9+ recommended
- `astral`

Install dependency:

```bash
pip install astral
