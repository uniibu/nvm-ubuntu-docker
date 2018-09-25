#!/usr/bin/env bash

chown root:root /var/run/docker.sock

VER=$(ls -rt /home/ubuntu/.nvm/versions/node/ | tail -1)

curl --silent -L https://git.io/fAN0v | /home/ubuntu/.nvm/versions/node/$VER/bin/node

exec "$@"