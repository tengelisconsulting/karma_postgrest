#!/bin/sh

docker run -it --rm --net=host \
       -e API_PG_USER=postgres \
       -e API_PG_PASSWORD=${PASSWORD} \
       -e PGHOST=localhost \
       -e PGPORT=5432 \
       -e PGDB=postgres \
       -e API_DB_SCHEMA=api \
       -e API_ANON_ROLE=anon \
       -e API_DB_POOL=10 \
       -e API_DB_POOL_TIMEOUT=5000 \
       -e API_DB_PORT=${PORT} \
       tengelisconsulting/karma_postgrest
