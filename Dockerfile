# Install from alpine/ubuntu ?
FROM ubuntu:22.04

LABEL version="1.0"

# Install ssh-client
RUN apt-get update \
    && apt-get install -y openssh-client \
    && apt-get install -y git \
    && apt-get update && apt-get install -y tree
# Install java ?

# User - root ------------------------------------
RUN mkdir -p /root/.ssh
COPY .ssh/id_ed25519 /root/.ssh/id_ed25519
#RUN chmod 700 /home/sshuser/*
#RUN eval "$(ssh-agent -s)" \
#    && ssh-add /root/.ssh/id_ed25519 \
RUN ssh-keyscan github.com >> /root/.ssh/known_hosts \
    && chmod 600 /root/.ssh/id_ed25519

RUN ls /root/ -la
RUN tree /root/
WORKDIR /root

RUN git clone git@github.com:unamura/market-ma.git
RUN ls /root/ -la

CMD ["/usr/sbin/sshd","-D"]