# vim:set ft=dockerfile:
FROM ubuntu

RUN  apt update
RUN  apt install curl net-tools iputils-ping -qy

COPY scripts/file-env.sh /usr/local/bin/
COPY scripts/setup-entrypoint.sh /usr/local/bin/

ENTRYPOINT ["setup-entrypoint.sh"]
