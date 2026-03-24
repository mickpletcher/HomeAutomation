# SunriseSunset

A simple sunrise and sunset calculator for home automation workflows.

This folder includes:

- `sunrise_sunset.py` for direct Python usage
- `Get-SunriseSunset.ps1` for PowerShell users
- `SunriseSunsetEquation.txt` with the hour angle reference equation

The Python script uses the `astral` library and Python's `zoneinfo` support to calculate sunrise and sunset times from GPS coordinates, a date, and a time zone. The PowerShell script wraps a small embedded Python block instead of reimplementing the solar math directly. `SunriseSunsetEquation.txt` contains the simplified hour angle formula used as a reference. 

## Why this is useful

This is handy for:

- Home Assistant automations
- exterior lights
- astronomy planning
- solar and weather related triggers
- schedule generation based on daylight

## Files in this folder

### `sunrise_sunset.py`
Direct Python script for calculating sunrise and sunset.

### `Get-SunriseSunset.ps1`
PowerShell wrapper that calls Python locally and returns a structured object.

### `SunriseSunsetEquation.txt`
A quick reference file containing the sunrise and sunset hour angle equation.

## Requirements

### Python
- Python 3.9 or newer recommended
- `astral`

Install the dependency:

```bash
pip install astral
