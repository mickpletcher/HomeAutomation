<#
===============================================================================
Title: Sunrise and Sunset Calculator
Author: OpenAI
Purpose:
    Calculate sunrise and sunset times for a specific date using exact
    GPS coordinates and a local time zone.

Requirements:
    - PowerShell 7+
    - Python installed
    - Astral installed in Python:
        pip install astral

How it works:
    This script calls a short embedded Python block because Python's Astral
    library is a fast, reliable way to calculate solar events accurately.

Why this approach:
    - Faster than manually porting all solar equations into PowerShell
    - Easier to maintain
    - Good fit for automation workflows
    - Works well in on prem environments if Python is installed locally

Notes:
    - The timezone must match the location being evaluated
    - In extreme northern or southern latitudes, some dates may have
      no sunrise or no sunset on certain days
    - Returned times are in the specified local timezone

Use cases:
    - Home Assistant and automation triggers
    - Outdoor lighting schedules
    - Astronomy planning
    - Solar panel event scheduling
===============================================================================
#>

function Get-SunriseSunset {
    <#
    .SYNOPSIS
        Returns sunrise and sunset times for a given date and GPS location.

    .DESCRIPTION
        Uses Python and the Astral library to calculate sunrise and sunset
        for the supplied latitude, longitude, date, and timezone.

    .PARAMETER Latitude
        Decimal latitude of the target location.

    .PARAMETER Longitude
        Decimal longitude of the target location.

    .PARAMETER Date
        The date to calculate for.

    .PARAMETER TimeZone
        IANA timezone string such as America/Chicago.

    .EXAMPLE
        Get-SunriseSunset -Latitude 36.3798 -Longitude -87.0353 `
            -Date '2026-06-21' -TimeZone 'America/Chicago'
    #>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [double]$Latitude,

        [Parameter(Mandatory)]
        [double]$Longitude,

        [Parameter(Mandatory)]
        [datetime]$Date,

        [Parameter(Mandatory)]
        [string]$TimeZone
    )

    # Build a compact Python script as a here string.
    # This avoids needing a separate .py file on disk.
    $pythonScript = @"
from datetime import date
from zoneinfo import ZoneInfo
from astral import LocationInfo
from astral.sun import sun
import json
import sys

latitude = float(sys.argv[1])
longitude = float(sys.argv[2])
year = int(sys.argv[3])
month = int(sys.argv[4])
day = int(sys.argv[5])
timezone_name = sys.argv[6]

tz = ZoneInfo(timezone_name)

location = LocationInfo(
    name="Custom Location",
    region="Custom Region",
    timezone=timezone_name,
    latitude=latitude,
    longitude=longitude
)

s = sun(location.observer, date=date(year, month, day), tzinfo=tz)

result = {
    "sunrise": s["sunrise"].isoformat(),
    "sunset": s["sunset"].isoformat()
}

print(json.dumps(result))
"@

    try {
        # Call Python and pass the parameters cleanly as command line args.
        $json = python -c $pythonScript `
            $Latitude `
            $Longitude `
            $Date.Year `
            $Date.Month `
            $Date.Day `
            $TimeZone 2>&1

        # If Python returned an error message instead of JSON, fail hard.
        if (-not $json -or $json -match 'Traceback|ModuleNotFoundError|ImportError') {
            throw "Python execution failed. Output: $json"
        }

        # Convert returned JSON into a PowerShell object.
        $result = $json | ConvertFrom-Json

        # Return a structured object with typed DateTime values.
        [pscustomobject]@{
            Latitude  = $Latitude
            Longitude = $Longitude
            Date      = $Date.ToString('yyyy-MM-dd')
            TimeZone  = $TimeZone
            Sunrise   = [datetimeoffset]::Parse($result.sunrise)
            Sunset    = [datetimeoffset]::Parse($result.sunset)
        }
    }
    catch {
        Write-Error "Failed to calculate sunrise and sunset. $($_.Exception.Message)"
    }
}

# ---------------------------------------------------------------------------
# EXAMPLE USAGE
# ---------------------------------------------------------------------------

# Exact GPS coordinates
$latitude  = 36.3798
$longitude = -87.0353

# Date to calculate
$targetDate = Get-Date '2026-06-21'

# Local timezone for the coordinates
$timeZone = 'America/Chicago'

# Run the calculation
$sunData = Get-SunriseSunset `
    -Latitude $latitude `
    -Longitude $longitude `
    -Date $targetDate `
    -TimeZone $timeZone

# Display results
$sunData | Format-List
