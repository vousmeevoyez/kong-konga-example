FROM ubuntu:latest

RUN  apt update
RUN  apt install curl -qy

WORKDIR /home

COPY --chown=755 scripts/file-env.sh /home
COPY --chown=755 scripts/setup-entrypoint.sh /home

ENTRYPOINT ["/home/setup-entrypoint.sh"]