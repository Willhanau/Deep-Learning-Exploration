#!/bin/bash

docker_repo="willhanau/tensorflow"
docker_tag="cuda9.0-cudnn7.0.5-tf1.8"
docker_file="Dockerfile_Cuda9.0_Tf1.8_build"

docker build -t $docker_repo:$docker_tag -f ./$docker_file .
docker push $docker_repo:$docker_tag
