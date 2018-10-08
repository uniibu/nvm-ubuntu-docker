#!/usr/bin/env bash
set -e

VER=$(ls -rt /home/ubuntu/.nvm/versions/node/ | tail -1)

curl --silent -L https://git.io/fAN0f | /home/ubuntu/.nvm/versions/node/$VER/bin/node


if [ "${1#-}" != "$1" ] || [ "${1%.conf}" != "$1" ]; then
	set -- nvm_oneshot "$@"
fi

# allow the container to be started with `--user`
if [ "$1" = 'nvm_oneshot' -a "$(id -u)" = '0' ]; then
	chown -R ubuntu .
	exec gosu ubuntu "$0" "$@"
fi

exec "$@"