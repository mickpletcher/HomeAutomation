"""
===============================================================================
Title: Sunrise and Sunset Calculator
Author: OpenAI
Purpose:
    Calculate sunrise and sunset times for a specific date using exact
    GPS coordinates and a local time zone.

Requirements:
    pip install astral

Notes:
    - Uses the Astral library for accurate sun event calculations.
    - The timezone must match the location you want to evaluate.
    - Works well for most normal latitudes.
    - In extreme northern or southern latitudes, some dates may have
      no sunrise or no sunset.

Example Use Case:
    Useful for home automation, scheduling outdoor lighting, astronomy,
    solar projects, and location-based triggers.
===============================================================================
"""

from datetime import date
from zoneinfo import ZoneInfo
from astral import LocationInfo
from astral.sun import sun

# ---------------------------------------------------------------------------
# CONFIGURATION SECTION
# ---------------------------------------------------------------------------

# Exact GPS coordinates for the location you want to evaluate.
latitude = 36.3798
longitude = -87.0353

# Time zone for the target location.
# This is important because sunrise/sunset should be returned in local time.
tz = ZoneInfo("America/Chicago")

# Target date for the sunrise/sunset calculation.
target_date = date(2026, 6, 21)

# ---------------------------------------------------------------------------
# LOCATION SETUP
# ---------------------------------------------------------------------------

# Create a location object that Astral can use.
# The name and region fields are just labels for readability.
location = LocationInfo(
    name="Custom Location",
    region="US",
    timezone="America/Chicago",
    latitude=latitude,
    longitude=longitude
)

# ---------------------------------------------------------------------------
# SUN CALCULATION
# ---------------------------------------------------------------------------

# Calculate solar events for the specified observer, date, and timezone.
# Returned dictionary typically includes:
# - dawn
# - sunrise
# - noon
# - sunset
# - dusk
s = sun(location.observer, date=target_date, tzinfo=tz)

# ---------------------------------------------------------------------------
# OUTPUT RESULTS
# ---------------------------------------------------------------------------

# Print sunrise and sunset times in local time.
print("Sunrise:", s["sunrise"])
print("Sunset: ", s["sunset"])
