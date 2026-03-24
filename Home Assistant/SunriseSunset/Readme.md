# SunriseSunset

A simple sunrise and sunset calculator for home automation workflows.

This folder includes:

- `sunrise_sunset.py` for direct Python usage
- `Get-SunriseSunset.ps1` for PowerShell users
- `SunriseSunsetEquation.txt` with the hour angle reference equation
- `INSTRUCTIONS.md` for a quick setup and usage guide

## Quick Links

- [Instructions](./INSTRUCTIONS.md)

The Python script uses the `astral` library and Python's `zoneinfo` support to calculate sunrise and sunset times from GPS coordinates, a date, and a time zone. The PowerShell script wraps a small embedded Python block instead of reimplementing the solar math directly.

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

### `INSTRUCTIONS.md`
A setup and usage guide with generic example coordinates and sample commands.

## Requirements

### Python
- Python 3.9 or newer recommended
- `astral`

Install the dependency:

```bash
pip install astral
```

### PowerShell
- PowerShell 7+
- Python installed and available in PATH
- `astral` installed in that Python environment

## Tutorial

### 1. Clone the repo

```bash
git clone https://github.com/mickpletcher/HomeAutomation.git
cd HomeAutomation
```

### 2. Go to the SunriseSunset folder

```bash
cd "Home Assistant/SunriseSunset"
```

### 3. Install the Python dependency

```bash
pip install astral
```

If you use multiple Python versions, use the exact interpreter you want:

```bash
python -m pip install astral
```

### 4. Get your GPS coordinates

Use decimal coordinates in this format:

- Latitude: `34.052235`
- Longitude: `-118.243683`

Replace those with your own location before running the script.

If your coordinates are in degrees, minutes, and seconds, convert them to decimal first.

Generic conversion example:

- `34° 03' 08" N` becomes `34.052222`
- `118° 14' 37" W` becomes `-118.243611`

### 5. Choose your timezone

Use an IANA timezone string.

Examples:

- `America/Chicago`
- `America/New_York`
- `America/Denver`
- `America/Los_Angeles`

For the generic example in this folder, use:

```text
America/Los_Angeles
```

### 6. Edit the Python script

Open `sunrise_sunset.py` and update these values:

```python
latitude = 34.052235
longitude = -118.243683
tz = ZoneInfo("America/Los_Angeles")
target_date = date(2026, 6, 21)
```

Then run it:

```bash
python sunrise_sunset.py
```

Expected output will look something like this:

```text
Sunrise: 2026-06-21 05:xx:xx-07:00
Sunset:  2026-06-21 20:xx:xx-07:00
```

### 7. Edit the PowerShell script

Open `Get-SunriseSunset.ps1` and update the example usage section near the bottom:

```powershell
$latitude  = 34.052235
$longitude = -118.243683
$targetDate = Get-Date '2026-06-21'
$timeZone = 'America/Los_Angeles'
```

Run it in PowerShell:

```powershell
./Get-SunriseSunset.ps1
```

You should get output similar to:

```text
Latitude  : 34.052235
Longitude : -118.243683
Date      : 2026-06-21
TimeZone  : America/Los_Angeles
Sunrise   : 6/21/2026 5:xx:xx AM -07:00
Sunset    : 6/21/2026 8:xx:xx PM -07:00
```

### 8. Reuse the PowerShell function directly

Instead of editing the bottom of the script every time, you can call the function with your own values:

```powershell
Get-SunriseSunset `
    -Latitude 34.052235 `
    -Longitude -118.243683 `
    -Date (Get-Date '2026-06-21') `
    -TimeZone 'America/Los_Angeles' | Format-List
```

### 9. Change the date for any day of the year

#### Python

```python
target_date = date(2026, 12, 25)
```

#### PowerShell

```powershell
$targetDate = Get-Date '2026-12-25'
```

### 10. Use this in automation

Typical use cases:

- run once daily and store sunrise and sunset
- trigger lights 30 minutes before sunset
- disable outdoor lights 30 minutes after sunrise
- use the result in a Home Assistant command line sensor
- generate schedules for camera modes or observatory gear

## Notes

- The timezone must match the actual physical location.
- Near polar regions, some dates may have no sunrise or no sunset.
- The PowerShell script is intentionally built as a wrapper around Python because it is simpler and easier to maintain than manually porting all of the solar calculations.

## Troubleshooting

### `ModuleNotFoundError: No module named 'astral'`
Install Astral:

```bash
pip install astral
```

### PowerShell says Python failed
Make sure Python is installed and in PATH:

```powershell
python --version
```

Then confirm Astral is installed in that same Python environment:

```powershell
python -m pip show astral
```

### Wrong time returned
Usually this is one of these problems:

- wrong timezone string
- wrong coordinates
- date entered incorrectly
- Python environment mismatch

## Math reference

The included `SunriseSunsetEquation.txt` contains a reference equation for the sunrise and sunset hour angle.

Use the scripts for actual calculations.

## Additional help

For a shorter setup guide, see [INSTRUCTIONS.md](./INSTRUCTIONS.md).

## License

This project inherits the repository license.
