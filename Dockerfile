# Install from alpine/ubuntu ?
FROM ubuntu:22.04

LABEL version="1.0"

# Install ssh-client, git
RUN apt-get update \
    && apt-get install -y openssh-client \
    && apt-get install -y openssh-server \
    && apt-get install -y git \
    && apt-get install -y openjdk-17-jdk \
    && apt-get install -y maven
# Install java ? openjdk 17

RUN ls /usr/sbin -la
# User - root ------------------------------------
RUN mkdir -p /root/.ssh
COPY .ssh/id_ed25519 /root/.ssh/id_ed25519
COPY .ssh/id_ed25519.pub /root/.ssh/id_ed25519.pub
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts \
    && chmod 600 /root/.ssh/*

RUN ls /root/ -la
WORKDIR /root

RUN git clone git@github.com:unamura/market-ma.git
RUN ls /root/market-ma -la

RUN service ssh start
# RUN /usr/sbin/sshd -D
# Expose docker port 22
EXPOSE 22

CMD ["/usr/sbin/sshd","-D"]