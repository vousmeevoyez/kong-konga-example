# vim:set ft=dockerfile:
FROM ubuntu

RUN  apt update
RUN  apt install curl -qy

WORKDIR /home

COPY scripts/file-env.sh ~
COPY scripts/setup-entrypoint.sh ~

RUN [ "chmod", "+x", "file-env.sh" ]
RUN [ "chmod", "+x", "setup-entrypoint.sh" ]

ENTRYPOINT ["setup-entrypoint.sh"]
