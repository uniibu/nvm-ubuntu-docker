# nvm-ubuntu-docker

For use with Portainer with volume mounted from host's /var/run/docker.sock to container's /var/run/docker.sock with write permission

This will install Nodejs using nvm under Ubuntu 16.04 with ssh access. Mostly used for developement environment

Default User: `ubuntu`
Default Password: `ubuntu`
Default Node = node (current version)
Note: You will be asked to change your password upon login


Exposed Ports: Will expose port 22, 8080-8089 Note: you must also publish each of these ports on portainer's port mapping.

Additional Feature:
This image will also add the container's published ports to the container's environment variables env


To run:
```
docker run --name=nvm-docker -d \
   -p 22 \
   -p 8080-8089 \
   unibtc/nvm-ubuntu-docker:latest
```