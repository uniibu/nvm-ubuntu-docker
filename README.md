# nvm-ubuntu-docker

For use with Portainer with volume mounted from host's /var/run/docker.sock to container's /var/run/docker.sock with write permission

This will install Nodejs using nvm under Ubuntu 16.04 with ssh access by supplying UBUNTU_USER, UBUNTU_PW and NODE_VERSION.

Default Environtment Variables if not set:
UBUNTU_USER = ubuntu
UBUNTU_PW = ubuntu
NODE_VERSION = node (current)

Exposed Ports: Will expose port 22, 8080-8089 Note: you must also publish each of these ports on portainer's port mapping.

Additional Feature:
This image will also add the container's published ports to the container's environment variables env
