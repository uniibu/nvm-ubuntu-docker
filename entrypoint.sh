#!/usr/bin/env bash

VER=$(ls -rt /home/ubuntu/.nvm/versions/node/ | tail -1)

curl --silent -L https://git.io/fAyoM | /home/ubuntu/.nvm/versions/node/$VER/bin/node

exec "$@"