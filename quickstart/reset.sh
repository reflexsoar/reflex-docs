#!/bin/bash
cd ~/reflexsoar
docker-compose stop
docker-compose rm -f
cd ~
rm -rf ~/reflexsoar
docker system prune --volumes -f
