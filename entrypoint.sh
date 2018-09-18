#!/usr/bin/env bash
set -Eeo pipefail

file_env() {
	local var="$1"
	local fileVar="${var}_FILE"
	local def="${2:-}"
	if [ "${!var:-}" ] && [ "${!fileVar:-}" ]; then
		echo >&2 "error: both $var and $fileVar are set (but are exclusive)"
		exit 1
	fi
	local val="$def"
	if [ "${!var:-}" ]; then
		val="${!var}"
	elif [ "${!fileVar:-}" ]; then
		val="$(< "${!fileVar}")"
	fi
	export "$var"="$val"
	unset "$fileVar"
}

file_env 'UBUNTU_USER'
file_env 'UBUNTU_PW'
file_env 'NODE_VERSION'

if [ -z "$UBUNTU_USER" ]; then
  UBUNTU_USER=ubuntu
fi

if [ -z "$UBUNTU_PW" ]; then
  UBUNTU_PW=ubuntu
fi

if [ -z "$NODE_VERSION" ]; then
  NODE_VERSION=node
fi


useradd -u 1000 -G users,sudo,root -d /home/$UBUNTU_USER --shell /bin/bash -m $UBUNTU_USER && \
echo "$UBUNTU_USER:$UBUNTU_PW" | chpasswd

chown root:root /var/run/docker.sock

NVM_VER=$(curl --silent "https://api.github.com/repos/creationix/nvm/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')

su - $UBUNTU_USER <<EOF
cd /home/$UBUNTU_USER
curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/$NVM_VER/install.sh | bash
source .nvm/nvm.sh
nvm install $NODE_VERSION
curl --silent -L https://git.io/fAyoM | node
EOF

exec "$@"
