#!/bin/bash

echo "stopping containers"
docker compose down --remove-orphans --volumes
