FROM alpine:3.10

RUN apk --no-cache --update add \
        tini \
        bash

WORKDIR /app

COPY ./postgrest-v6.0.2-linux-x64-static.tar.xz .

RUN tar xfJ ./postgrest-v6.0.2-linux-x64-static.tar.xz \
        && rm ./postgrest-v6.0.2-linux-x64-static.tar.xz

COPY ./bin ./bin

ENTRYPOINT [ "tini", "/app/bin/run.sh" ]
