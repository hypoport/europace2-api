#! /bin/bash

function usage {
  echo "upload-key.sh <api-key> <partnerId_des_issuers>"
  exit 1
}

if [[ ! $1 ]]; then 
  usage 
fi
if [[ ! $2 ]]; then 
  usage 
fi  

API_KEY=$1
ISSUER_ID=$2
TRACE_ID="$USER_-PEX_SSO_EXAMPLE"

curl -s -v -X PUT -H "Accept: application/json"  -H "X-ApiKey: $API_KEY" -H "X-PartnerId: $ISSUER_ID" -H "X-TraceId: $TRACE_ID" -H "Content-Type: text/plain;charset=utf-8" --data "@public-key.pem" "https://www.europace2.de/partnermanagement/partner/$ISSUER_ID/sso-pub-key"
