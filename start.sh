#!/bin/bash
docker network create kong-net
docker network create konga-net
docker-compose down --rmi local
docker-compose up --build -d
docker-compose -f docker-compose.production.yml up -d kong
