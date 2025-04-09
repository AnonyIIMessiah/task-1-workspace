#!/bin/bash

docker-compose -f jenkins/docker-compose.yaml down
docker rmi tasks-jenkins
# sudo rm -rf jenkins/jenkins/data