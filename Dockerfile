FROM ubuntu:16.04

ENV HOME /home/ubuntu
ENV USER_ID 1000
ENV GROUP_ID 1000

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN groupadd -g ${GROUP_ID} ubuntu \
    && useradd -u ${USER_ID} -g ubuntu -s /bin/bash -m -d /home/ubuntu ubuntu \
    && echo "ubuntu:ubuntu" | chpasswd && groupadd docker && usermod -aG docker ubuntu

RUN apt-get update && \
    apt-get -y install \
    locales \
    openssh-server \
    sudo \
    curl \
    git \
    build-essential \
    nano \
    gosu \
    bash-completion && \
    mkdir /var/run/sshd && \
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && \
    echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    rm -rf /var/lib/apt/lists/* && \
    localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 && \
    apt-get -y autoclean

ENV LANG en_US.UTF-8

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
COPY check.sh /usr/local/bin/check.sh
RUN chmod +x /usr/local/bin/check.sh
ADD ./bin /usr/local/bin
RUN chmod +x /usr/local/bin/nvm_oneshot

RUN echo "/usr/local/bin/check.sh" >> ~/.bashrc
RUN echo "source /.docker_ports" >> ~/.bashrc

USER "ubuntu"
RUN curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
RUN source ~/.nvm/nvm.sh && nvm install node

VOLUME ["/home/ubuntu"]

EXPOSE 22 8080 8081 8082 8083 8084 8085 8086 8087 8088 8089

WORKDIR /home/ubuntu

ENTRYPOINT [ "/usr/local/bin/entrypoint.sh" ] 

CMD ["nvm_oneshot"]
