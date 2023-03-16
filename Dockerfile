# Install git from alpine/ubuntu ?
FROM ubuntu:latest

LABEL version="1.0"

RUN apt-get update \
    && apt-get install -y openssh-client

# Install git
RUN apt-get update \
    && apt-get install -y git

RUN useradd -m sshuser
RUN mkdir -p /home/sshuser/.ssh

COPY .ssh/id_ed25519 /home/sshuser/.ssh/id_ed25519
#COPY .ssh/id_ed25519.pub /home/sshuser/.ssh/id_ed25519.pub

RUN chown -R sshuser:sshuser /home/sshuser \
    && chmod 700 /home/sshuser
RUN chown -R sshuser:sshuser /home/sshuser/.ssh/id_ed25519 \
    && chmod 700 /home/sshuser/.ssh/id_ed25519

RUN eval "$(ssh-agent -s)" \
    && ssh-add /home/sshuser/.ssh/id_ed25519 \
    && ssh-keyscan github.com >> /home/sshuser/.ssh/known_hosts

WORKDIR /home/sshuser
USER sshuser
RUN git clone git@github.com:unamura/market-ma.git
WORKDIR /home/sshuser/market-ma
RUN git fetch

USER root
RUN ls /home/sshuser/market-ma -la
RUN ls ~/ -la

CMD ["/usr/sbin/sshd","-D"]