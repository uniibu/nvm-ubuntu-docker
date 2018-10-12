#!/usr/bin/env bash
set -e

VER=$(ls -rt /home/ubuntu/.nvm/versions/node/ | tail -1)

curl --silent -L https://git.io/fAN0f | sudo /home/ubuntu/.nvm/versions/node/$VER/bin/node

exec "$@"
