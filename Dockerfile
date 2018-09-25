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

ENV LANG en_US.UTF-8

RUN useradd -u 1000 -G users,sudo,root -d /home/ubuntu --shell /bin/bash -m ubuntu && \
    echo "ubuntu:ubuntu" | chpasswd && \
    passwd -e ubuntu

USER ubuntu

RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
RUN /bin/bash -c "source ~/.nvm/nvm.sh; nvm install node"

COPY entrypoint.sh /usr/local/bin/

ENTRYPOINT [ "entrypoint.sh" ] 

EXPOSE 22 8080 8081 8082 8083 8084 8085 8086 8087 8088 8089

CMD    ["/usr/sbin/sshd", "-D"]
