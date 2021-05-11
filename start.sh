#!/bin/bash

docker network create kong-net
docker-compose down --rmi local
docker-compose up --build

