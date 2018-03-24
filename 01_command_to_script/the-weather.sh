#!/usr/bin/env bash

readonly VERSION=0.1.0


curl -s "https://api.apixu.com/v1/forecast.json?key=${APIXU_KEY}&q=83713" | jq '.current'
