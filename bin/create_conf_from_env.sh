#!/bin/bash


assert_env() {
    val=$(eval echo \$$1)
    if [ "${val}" = "" ]; then
        echo "SET $1"
        exit 1
    fi
}


assert_env 'PGHOST'
assert_env 'PGPORT'
assert_env 'PGDB'

assert_env 'PGST_PORT'
assert_env 'PGST_USER'
assert_env 'PGST_PASS'
assert_env 'PGST_SCHEMA'
assert_env 'PGST_ANON_ROLE'
assert_env 'PGST_POOL'
assert_env 'PGST_POOL_TIMEOUT'


cat << EOF
db-uri = "postgres://${PGST_USER}:${PGST_PASS}@${PGHOST}:${PGPORT}/${PGDB}"
db-schema = "${PGST_SCHEMA}" # this schema gets added to the search_path of every request
db-anon-role = "${PGST_ANON_ROLE}"

db-pool = ${PGST_POOL}
db-pool-timeout = ${PGST_POOL_TIMEOUT}

# server-host = "!4"
server-port = ${PGST_PORT}

## unix socket location
## if specified it takes precedence over server-port
# server-unix-socket = "/tmp/pgrst.sock"

## base url for swagger output
# server-proxy-uri = "${API_PROXY_URI}"

## choose a secret, JSON Web Key (or set) to enable JWT auth
## (use "@filename" to load from separate file)
# jwt-secret = "foo"
# secret-is-base64 = false
# jwt-aud = "your_audience_claim"

## limit rows in response
# max-rows = 1000

## stored proc to exec immediately after auth
# pre-request = "stored_proc_name"

## jspath to the role claim key
# role-claim-key = ".role"

## extra schemas to add to the search_path of every request
# db-extra-search-path = "extensions, util"

## stored proc that overrides the root "/" spec
## it must be inside the db-schema
# root-spec = "stored_proc_name"

## content types to produce raw output
# raw-media-types="image/png, image/jpg"
EOF
