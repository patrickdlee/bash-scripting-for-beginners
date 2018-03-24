#!/usr/bin/env bash
#
# Send a request to the Apixu API to get the current weather in the city or zip
# code provided to the script.

readonly VERSION=0.2.2

readonly PROGRAM_NAME=$(basename "$0")

readonly location="${1}"


usage() {
  cat <<EOT
Usage: ${PROGRAM_NAME} <location>

Shows the current weather in the location (city or zip code) provided.

ARGUMENTS:
  location:   city or zip code

ENVIRONMENT:
  APIXU_KEY:  API key for Apixu weather API (https://www.apixu.com/)
EOT
}


# Check for Apixu API key
if [[ -z "${APIXU_KEY}" ]]; then
  echo "No Apixu API key is set."
  usage
  exit 1
fi

# Make sure location is provided
if [[ -z "${location}" ]]; then
  echo "No location provided."
  usage
  exit 1
fi

curl -s "https://api.apixu.com/v1/forecast.json?key=${APIXU_KEY}&q=${location}" | jq '.current'

exit 0
