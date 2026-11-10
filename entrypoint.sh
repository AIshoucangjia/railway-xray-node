#!/bin/sh
set -e
# Railway supplies $PORT at runtime. UUID and WS_PATH come from Railway
# Variables (never hard-code the node UUID in chat or in this repo).
: "${UUID:?Set UUID in Railway Variables}"
: "${WS_PATH:?Set WS_PATH in Railway Variables, e.g. /vless}"
: "${PORT:?Railway should supply PORT}"
# envsubst is not in alpine base; use sed with a delimiter unlikely in values.
sed -e "s|\${PORT}|${PORT}|g" -e "s|\${UUID}|${UUID}|g" -e "s|\${WS_PATH}|${WS_PATH}|g" \
  /config.template.json > /tmp/config.json
exec /usr/local/bin/xray run -c /tmp/config.json
