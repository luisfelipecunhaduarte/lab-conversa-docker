#!/bin/bash

echo "building docker image"
docker build -t lab-conversa-docker -f Dockerfile .

echo "running containers"
docker compose up -d