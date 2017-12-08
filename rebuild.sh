#!/bin/bash
docker build . -t wal && docker-compose rm -f master standby && docker-compose up
