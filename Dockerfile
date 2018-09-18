FROM ubuntu:16.04

RUN apt-get update && \
    apt-get -y install \
    locales \
    openssh-server \
    sudo \
    curl \
    git \
    build-essential \
    nano \
    bash-completion && \
    mkdir /var/run/sshd && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    rm -rf /var/lib/apt/lists/* && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

RUN apt-get update \
    && apt-get install -y curl \
    && apt-get -y autoclean
    NVM_LATEST=$(curl --silent "https://api.github.com/repos/creationix/nvm/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")') \
    && curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/$NVM_LATEST/install.sh | bash

    
ENV LANG en_US.UTF-8
 
COPY ["entrypoint.sh","/usr/local/bin/entrypoint.sh"]

RUN chmod +x /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

EXPOSE 22 80 443

CMD    ["/usr/sbin/sshd", "-D"]
