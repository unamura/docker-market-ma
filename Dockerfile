# Install from alpine/ubuntu ?
FROM ubuntu:22.04

LABEL version="1.0"

# Install ssh-client, git
RUN apt-get update \
    && apt-get install -y openssh-client \
    && apt-get install -y git \
    && apt-get install -y openjdk-17-jdk
# Install java ? openjdk 17

# User - root ------------------------------------
RUN mkdir -p /root/.ssh
COPY .ssh/id_ed25519 /root/.ssh/id_ed25519
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts \
    && chmod 600 /root/.ssh/id_ed25519

RUN ls /root/ -la
WORKDIR /root

RUN git clone git@github.com:unamura/market-ma.git
RUN ls /root/market-ma -la

CMD ["/usr/sbin/sshd","-D"]