#!/bin/sh
# RunCat Neo — Bitcoin price sample.
#
# Fetches the current Bitcoin price in USD from the CoinGecko public API
# and writes a Custom Metrics JSON snapshot shaped like:
#
#     {
#       "title": "Bitcoin",
#       "symbol": "bitcoinsign",
#       "metricsBarValue": "$61.9K",
#       "metrics": [
#         { "title": "Current", "formattedValue": "$61888.04" }
#       ],
#       "lastUpdatedDate": "2026-06-05T04:50:40Z"
#     }

set -eu

outputFile="${RUNCAT_OUT_FILE:-$HOME/Developer/RunCatNeo/customMetrics/get-bitcoin-price/bitcoin.json}"
outputDirectory=$(dirname "$outputFile")
logFile="${RUNCAT_LOG_FILE:-${outputFile}.log}"
apiURL="https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=usd"
responseFile=
temporaryFile=

if ! mkdir -p "$outputDirectory"; then
    printf 'ERROR: Cannot create output directory: %s\n' "$outputDirectory" >&2
    exit 1
fi

log() {
    timestamp=$(date -u +%Y-%m-%dT%H:%M:%SZ)
    message="[$timestamp] $*"
    printf '%s\n' "$message" >&2
    if ! printf '%s\n' "$message" >> "$logFile"; then
        printf 'ERROR: Cannot write diagnostic log: %s\n' "$logFile" >&2
        return 1
    fi
}

cleanup() {
    if [ -n "$responseFile" ]; then
        rm -f "$responseFile"
    fi
    if [ -n "$temporaryFile" ]; then
        rm -f "$temporaryFile"
    fi
}

on_exit() {
    exitStatus=$?
    cleanup
    if [ "$exitStatus" -ne 0 ]; then
        log "ERROR: Update stopped with exit status $exitStatus." || :
    fi
}

trap on_exit EXIT
trap 'exit 1' HUP INT TERM

log "Starting Bitcoin price update."
log "Output file: $outputFile"
log "Diagnostic log: $logFile"

if ! responseFile=$(mktemp "${TMPDIR:-/tmp}/runcat-bitcoin-response.XXXXXX"); then
    log "ERROR: Could not create a temporary file for the API response."
    exit 1
fi

log "Requesting Bitcoin price from CoinGecko."
if httpStatus=$(curl --silent --show-error --connect-timeout 10 --max-time 30 \
    --output "$responseFile" --write-out '%{http_code}' "$apiURL"); then
    log "CoinGecko request completed with HTTP status $httpStatus."
else
    curlStatus=$?
    log "ERROR: CoinGecko request failed (curl exit status $curlStatus)."
    exit "$curlStatus"
fi

if [ "$httpStatus" != "200" ]; then
    responsePreview=$(head -c 300 "$responseFile" | tr '\n' ' ')
    if [ -n "$responsePreview" ]; then
        log "ERROR: Unexpected HTTP status $httpStatus. Response preview: $responsePreview"
    else
        log "ERROR: Unexpected HTTP status $httpStatus with an empty response."
    fi
    exit 1
fi

log "Extracting the USD price from the API response."
price=$(sed -nE 's/.*"usd"[[:space:]]*:[[:space:]]*([0-9]+([.][0-9]+)?).*/\1/p' "$responseFile")
if [ -z "$price" ]; then
    responsePreview=$(head -c 300 "$responseFile" | tr '\n' ' ')
    log "ERROR: Could not find a numeric bitcoin.usd value in the API response."
    if [ -n "$responsePreview" ]; then
        log "Response preview: $responsePreview"
    fi
    exit 1
fi

if ! awk -v price="$price" 'BEGIN { exit !(price ~ /^[0-9]+([.][0-9]+)?$/ && price > 0) }'; then
    log "ERROR: CoinGecko returned an invalid Bitcoin price: $price"
    exit 1
fi
log "Price extracted and validated: $price USD."

metricsBarValue=$(awk -v price="$price" 'BEGIN {
    if (price >= 1000000) printf "$%.2fM", price / 1000000
    else if (price >= 1000) printf "$%.1fK", price / 1000
    else printf "$%.2f", price
}')
currentValue=$(awk -v price="$price" 'BEGIN { printf "$%.2f", price }')
lastUpdatedDate=$(date -u +%Y-%m-%dT%H:%M:%SZ)

if ! temporaryFile=$(mktemp "$outputDirectory/.bitcoin-XXXXXX"); then
    log "ERROR: Could not create a temporary output file in $outputDirectory."
    exit 1
fi

log "Writing the metrics snapshot to a temporary file."
if ! cat > "$temporaryFile" <<EOF
{
  "title": "Bitcoin",
  "symbol": "bitcoinsign",
  "metricsBarValue": "$metricsBarValue",
  "metrics": [
    { "title": "Current", "formattedValue": "$currentValue" }
  ],
  "lastUpdatedDate": "$lastUpdatedDate"
}
EOF
then
    log "ERROR: Failed to write the metrics snapshot."
    exit 1
fi

if [ ! -s "$temporaryFile" ]; then
    log "ERROR: The generated metrics snapshot is empty; output was not replaced."
    exit 1
fi

log "Replacing the output file atomically."
if ! mv "$temporaryFile" "$outputFile"; then
    log "ERROR: Could not replace the output file: $outputFile"
    exit 1
fi
temporaryFile=
log "Update completed successfully."
