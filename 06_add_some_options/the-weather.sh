#!/usr/bin/env bash
#
# Send a request to the Apixu API to get the current weather or forecast in the
# city or zip code provided to the script.

readonly VERSION=0.3.0

readonly PROGRAM_NAME=$(basename "$0")


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

# Must provide an option
if [[ $# -eq 0 ]]; then
  echo "No option provided."
  usage
  exit 1
fi

# Parse command line options
while getopts "c:f:hv" opt; do
  case ${opt} in
    c )
      readonly location=$OPTARG
      curl -s "https://api.apixu.com/v1/forecast.json?key=${APIXU_KEY}&q=${location}" | jq '.current'
      ;;
    f )
      readonly location=$OPTARG
      curl -s "https://api.apixu.com/v1/forecast.json?key=${APIXU_KEY}&q=${location}" | jq '.forecast.forecastday'
      ;;
    h )
      usage
      ;;
    v )
      echo "${VERSION}"
      ;;
    ? )
      usage
      exit 1
  esac
done

exit 0
