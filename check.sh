#!/usr/bin/env bash

# Check for user password if still using ubuntu, tell user to change it

SALT=$(sudo getent shadow ubuntu | cut -d$ -f3)
KEY=$(sudo getent shadow ubuntu | cut -d: -f2)
HASH=$(python3 -c 'import crypt; print(crypt.crypt("ubuntu", "$6$'$SALT'"))')

if [[ $HASH == $KEY ]]; then
  echo "Change your password"
  passwd ubuntu
fi