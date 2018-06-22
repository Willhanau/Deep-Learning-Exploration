#!/bin/bash

#docker image variables
docker_repo='willhanau/tensorflow'
docker_tag='NGC-18.05-py2-DB-dlbs-mlperf'
pwd=$(pwd)
workspace_mount="$pwd/Workspace"
home_mount="/home/$USER"
data_mount="/raid"

nvidia-docker run --shm-size=1g \
  --ulimit memlock=-1 \
  --ulimit stack=67108864 \
  --rm -it -v $home_mount:/home \
  -v $workspace_mount:/mnt \
  -v $data_mount:/Data \
  $docker_repo:$docker_tag
