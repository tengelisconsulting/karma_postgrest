#!/bin/sh


set -v

/app/bin/create_conf_from_env.sh > /app/postgrest.conf

cat /app/postgrest.conf

/app/postgrest /app/postgrest.conf
