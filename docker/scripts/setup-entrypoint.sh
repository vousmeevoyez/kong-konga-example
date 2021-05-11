#!/bin/bash
set -e

source file-env.sh

file_env 'KONG_HOST'
file_env 'KONG_PORT'
file_env 'ADMIN_ROUTE'
file_env 'KONGA_CONSUMER_ID'
file_env 'AUTH_KEY'


# API heartcheck
while ! curl "http://${KONG_HOST}:${KONG_PORT}" &> /dev/null
do
  echo "$(date) - still trying"
  sleep 1
done

echo $AUTH_KEY

## MAKE ADM SERVICE
curl -i -X POST "http://${KONG_HOST}:${KONG_PORT}/services" \
  --data "name=${ADMIN_ROUTE}" \
  --data "url=http://${KONG_HOST}:${KONG_PORT}"

## MAKE ADM ROUTE IN SERVICE
curl -i -X POST "http://${KONG_HOST}:${KONG_PORT}/services/${ADMIN_ROUTE}/routes" \
     -H "Content-Type: application/json" \
     -d "{\"name\": \"${ADMIN_ROUTE}\", \"paths\": [ \"/${ADMIN_ROUTE}\" ]}"
    
## ADD KEY-AUTH PLUGIN TO SERVICE
curl -X POST "http://${KONG_HOST}:${KONG_PORT}/services/${ADMIN_ROUTE}/plugins" \
    --data "name=key-auth"  \
    --data "config.key_names=apikey"

## MAKE CONGA CONSUMER
curl -X POST "http://${KONG_HOST}:${KONG_PORT}/consumers" \
 --data 'username=konga' \
 --data "custom_id=${KONGA_CONSUMER_ID}"

## REGISTER PLUGIN IN CONSUMER
curl -X POST \
  "http://${KONG_HOST}:${KONG_PORT}/consumers/konga/key-auth" \
  -d "key=${AUTH_KEY}"
