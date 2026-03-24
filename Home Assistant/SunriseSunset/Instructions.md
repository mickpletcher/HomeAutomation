# Instructions

## Purpose

This folder contains sunrise and sunset calculation tools for automation workflows using either Python or PowerShell.

Included files:

- `sunrise_sunset.py`
- `Get-SunriseSunset.ps1`
- `SunriseSunsetEquation.txt`

## Requirements

### Python
- Python 3.9 or newer
- `astral`

Install dependency:

```bash
pip install astral
```

### PowerShell
- PowerShell 7+
- Python installed and available in PATH
- `astral` installed in the same Python environment

## Setup

1. Clone the repository.
2. Open the `Home Assistant/SunriseSunset` folder.
3. Install `astral`.
4. Update the coordinates, date, and timezone in the script you want to use.

## Coordinates

Use decimal GPS coordinates.

Example test coordinates:

- Latitude: `34.052235`
- Longitude: `-118.243683`

Replace those with your own location before running the script.

If your coordinates are in degrees, minutes, and seconds, convert them first.

Generic conversion example:

- `34° 03' 08" N` becomes `34.052222`
- `118° 14' 37" W` becomes `-118.243611`

## Timezone

Use an IANA timezone string.

Example:

- `America/Los_Angeles`

## Python Usage

Edit these values in `sunrise_sunset.py`:

```python
latitude = 34.052235
longitude = -118.243683
tz = ZoneInfo("America/Los_Angeles")
target_date = date(2026, 6, 21)
```

Run:

```bash
python sunrise_sunset.py
```

## PowerShell Usage

Edit these values near the bottom of `Get-SunriseSunset.ps1`:

```powershell
$latitude  = 34.052235
$longitude = -118.243683
$targetDate = Get-Date '2026-06-21'
$timeZone = 'America/Los_Angeles'
```

Run:

```powershell
./Get-SunriseSunset.ps1
```

Or call the function directly:

```powershell
Get-SunriseSunset `
    -Latitude 34.052235 `
    -Longitude -118.243683 `
    -Date (Get-Date '2026-06-21') `
    -TimeZone 'America/Los_Angeles' | Format-List
```

## Output

The scripts return sunrise and sunset times in the specified local timezone.

## Notes

- Make sure the timezone matches the actual location.
- Near polar regions, some dates may have no sunrise or no sunset.
- The PowerShell script uses embedded Python because it is simpler and easier to maintain than porting the astronomy math manually.

## Troubleshooting

### Astral not found

Install it with:

```bash
pip install astral
```

### Python not found from PowerShell

Check Python:

```powershell
python --version
```

### Wrong times returned

Common causes:

- wrong timezone
- wrong coordinates
- wrong date
- wrong Python environment

## Math Reference

`SunriseSunsetEquation.txt` contains a reference equation for the sunrise and sunset hour angle.

Use the scripts for actual calculations.
