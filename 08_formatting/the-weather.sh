#!/usr/bin/env bash
#
# Send a request to the Apixu API to get the current weather or forecast in the
# city or zip code provided to the script.

readonly VERSION=0.4.0

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

# Get weather for location
get_weather() {
  local location="${1}"
  local weather_type="${2}"

  json=$(curl -s "${BASE_API_URL}/forecast.json?key=${APIXU_KEY}&q=${location}" | jq '.')
  city=$(echo "${json}" | jq -r '.location.name')
  region=$(echo "${json}" | jq -r '.location.region')
  country=$(echo "${json}" | jq -r '.location.country')

  case "$weather_type" in
    current )
      condition=$(echo "${json}" | jq -r '.current.condition.text')
      temperature=$(echo "${json}" | jq -r '.current.temp_f')
      wind_speed=$(echo "${json}" | jq -r '.current.wind_mph')
      echo "Right now in $city, $region, $country..."
      echo "  it is $condition with a temperature of $temperature F and a $wind_speed MPH wind."
      ;;
    forecast )
      condition=$(echo "${json}" | jq -r '.forecast.forecastday[0].day.condition.text')
      low_temperature=$(echo "${json}" | jq -r '.forecast.forecastday[0].day.mintemp_f')
      high_temperature=$(echo "${json}" | jq -r '.forecast.forecastday[0].day.maxtemp_f')
      wind_speed=$(echo "${json}" | jq -r '.forecast.forecastday[0].day.maxwind_mph')
      echo "Today in $city, $region, $country..."
      echo -n "  it will be $condition with a low of $low_temperature F, a high of $high_temperature F,"
      echo " and a maximum wind speed of $wind_speed MPH."
      ;;
    ? )
      echo "Invalid weather type."
      exit 1
      ;;
  esac
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
        get_weather "${OPTARG}" current
        ;;
      f )
        check_api_key_exists
        get_weather "${OPTARG}" forecast
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
