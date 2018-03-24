#!/usr/bin/env bash
#
# Send a request to the Apixu API to get the current weather or forecast in the
# city or zip code provided to the script.

readonly VERSION=0.3.1

readonly PROGRAM_NAME=$(basename "$0")
readonly ARGS=( "$@" )
readonly BASE_API_URL="https://api.apixu.com/v1"


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
check_api_key_exists() {
  if [[ -z "${APIXU_KEY}" ]]; then
    echo "No Apixu API key is set."
    usage
    exit 1
  fi
}

# Get current weather for location
get_current_weather() {
  local location="${1}"

  curl -s "${BASE_API_URL}/current.json?key=${APIXU_KEY}&q=${location}" | jq '.current'
}

# Get forecast for location
get_forecast() {
  local location="${1}"

  curl -s "${BASE_API_URL}/forecast.json?key=${APIXU_KEY}&q=${OPTARG}" | jq '.forecast.forecastday'
}

main() {
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
        check_api_key_exists
        get_current_weather "${OPTARG}"
        ;;
      f )
        check_api_key_exists
        get_forecast "${OPTARG}"
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
}


main ${ARGS[*]}
exit 0
