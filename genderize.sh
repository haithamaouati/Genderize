#!/bin/bash

# Author: Haitham Aouati
# GitHub: github.com/haithamaouati

# Text format
normal="\e[0m"
bold="\e[1m"
result="\e[1;32m"
faint="\e[2m"
underlined="\e[4m"

# Check dependencies
for cmd in figlet curl jq bc; do
  if ! command -v "$cmd" &>/dev/null; then
    echo -e "Error: '$cmd' is required but not installed. Install it and try again."
    exit 1
  fi
done

print_banner() {
  clear
  figlet -f standard "Genderize"
  echo -e "${bold}Genderize ${normal}— Check the Gender of a Name\n"
  echo -e " Author: Haitham Aouati"
  echo -e " GitHub: ${underlined}github.com/haithamaouati${normal}\n"
}

print_banner

API_URL="https://api.genderize.io"

show_help() {
  echo "Usage: $0 -n <NAME> [-c COUNTRY]"
  echo
  echo "Options:"
  echo "  -n, --name       Specify the name to analyze (required)"
  echo "  -c, --country    Optional country ID (e.g., DZ)"
  echo -e "  -h, --help       Show this help message\n"
}

# Parse args
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    -n|--name)
      NAME="$2"
      shift 2
      ;;
    -c|--country)
      if [[ -z "$2" || "$2" == -* ]]; then
        echo -e "Error: country code for -c|--country is missing.\n"
        show_help
        exit 1
      fi
      COUNTRY="$2"
      shift 2
      ;;
    -h|--help)
      show_help
      exit 0
      ;;
    *)
      echo "Unknown parameter: $1"
      show_help
      exit 1
      ;;
  esac
done

if [[ -z "$NAME" ]]; then
  echo -e "Error: name is required.\n"
  show_help
  exit 1
fi

# Build request URL
URL="${API_URL}?name=${NAME}"
[[ -n "$COUNTRY" ]] && URL+="&country_id=${COUNTRY}"

# API call
RESPONSE=$(curl -s "$URL")

# Extract values with jq
COUNT=$(echo "$RESPONSE" | jq -r '.count // "N/A"')
NAME_RESULT=$(echo "$RESPONSE" | jq -r '.name // "N/A"')
GENDER=$(echo "$RESPONSE" | jq -r '.gender // "Unknown"')
RAW_PROBABILITY=$(echo "$RESPONSE" | jq -r '.probability // 0')
PROBABILITY=$(printf "%.0f%%" "$(echo "$RAW_PROBABILITY * 100" | bc -l)")

# Resolve country name from countries.json
if [[ -n "$COUNTRY" && -f "countries.json" ]]; then
  COUNTRY_NAME=$(jq -r --arg code "$COUNTRY" '.[] | select(.code == $code) | .name' countries.json)
else
  COUNTRY_NAME="N/A"
fi

# Output
echo -e "Count: ${result}$COUNT${normal}"
echo -e "Name: ${result}$NAME_RESULT${normal}"
echo -e "Country ID: ${result}${COUNTRY:-N/A}${normal}"
echo -e "Gender: ${result}$GENDER${normal}"
echo -e "Probability: ${result}$PROBABILITY${normal}"
echo -e "\n${result}$NAME_RESULT ${normal}in ${result}${COUNTRY_NAME:-N/A} ${normal}is ${result}$GENDER ${normal}with ${result}$PROBABILITY ${normal}certainty\n"
