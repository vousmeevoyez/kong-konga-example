# vim:set ft=dockerfile:
FROM postgres:9.6

COPY scripts/init.sql /docker-entrypoint-initdb.d/
