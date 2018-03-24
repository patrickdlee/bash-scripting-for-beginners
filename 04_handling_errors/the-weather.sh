#!/usr/bin/env bash
#
# Send a request to the Apixu API to get the current weather in the city or zip
# code provided to the script.

readonly VERSION=0.2.1

readonly location="${1}"


# Check for Apixu API key
if [[ -z "${APIXU_KEY}" ]]; then
  echo "No Apixu API key is set."
  usage
  exit 1
fi

if [[ -z "${location}" ]]; then
  echo "No location provided."
  exit 1
fi

# APIXU_KEY is an environment variable that must be set to a valid API key
curl -s "https://api.apixu.com/v1/forecast.json?key=${APIXU_KEY}&q=${location}" | jq '.current'

exit 0
