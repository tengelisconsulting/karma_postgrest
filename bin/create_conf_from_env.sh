#!/bin/bash


assert_env() {
    val=$(eval echo \$$1)
    if [ "${val}" = "" ]; then
        if [ "$2" = "" ]; then
            echo "SET $1"
            exit 1
        else
            eval $1=$2
        fi
    fi
}

assert_env 'API_PG_USER'
assert_env 'API_PG_PASSWORD'
assert_env 'PGHOST'
assert_env 'PGPORT' 5432
assert_env 'PGDB' postgres

assert_env 'API_DB_SCHEMA'
assert_env 'API_ANON_ROLE'
assert_env 'API_DB_POOL'
assert_env 'API_DB_POOL_TIMEOUT'
assert_env 'API_DB_PORT'
# 'API_PROXY_URI' -- need not be set

cat << EOF
db-uri = "postgres://${API_PG_USER}:${API_PG_PASSWORD}@${PGHOST}:${PGPORT}/${PGDB}"
db-schema = "${API_DB_SCHEMA}" # this schema gets added to the search_path of every request
db-anon-role = "${API_ANON_ROLE}"

db-pool = ${API_DB_POOL}
db-pool-timeout = ${API_DB_POOL_TIMEOUT}

# server-host = "!4"
server-port = ${API_DB_PORT}

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
