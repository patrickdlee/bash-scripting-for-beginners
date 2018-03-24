#!/usr/bin/env bash
#
# Send a request to the Apixu API to get the current weather in the city or zip
# code provided to the script.

readonly VERSION=0.2.0

readonly location="${1}"


# APIXU_KEY is an environment variable that must be set to a valid API key
curl -s "https://api.apixu.com/v1/forecast.json?key=${APIXU_KEY}&q=${location}" | jq '.current'
