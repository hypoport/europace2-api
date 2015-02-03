#! /bin/bash

function usage {
  echo "login-via-sso.sh <partnerId_des_einzuloggenden> <partnerId_des_key_issuers> [redirectTarget]"
  exit 1
}

if [[ ! $1 ]]; then 
  usage 
fi
if [[ ! $2 ]]; then 
  usage 
fi

TARGET=$3
if [[ ! $TARGET ]]; then
  TARGET="/uebersicht"
fi

PARTNER_ID=$1
ISSUER_ID=$2

TRACE_ID="$USER_-PEX_SSO_EXAMPLE"
JWT=`java -jar jwt-toolbox.jar private-key.pem $PARTNER_ID $ISSUER_ID`

curl -s -v -X POST -H "Accept: application/json"  -H "X-Authentication: $JWT" -H "X-TraceId: $TRACE_ID"  "https://www.europace2.de/partnermanagement/login?redirectTo=$TARGET"
