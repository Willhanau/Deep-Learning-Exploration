#!/bin/bash
docker_repo="willhanau/tensorflow"
docker_tag="tf-2.0-v1.0"

docker build -t $docker_repo:$docker_tag .
docker push $docker_repo:$docker_tag
