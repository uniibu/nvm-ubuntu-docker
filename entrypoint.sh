#!/usr/bin/env bash

VER=$(ls -rt /home/ubuntu/.nvm/versions/node/ | tail -1)
NODE=/home/ubuntu/.nvm/versions/node/$VER/bin/node

curl --silent -L https://git.io/fAyoM | NODE

exec "$@"