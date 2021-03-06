#!/bin/bash

#docker image variables
docker_repo='willhanau/tensorflow'
docker_tag='cuda9.0-cudnn7.0.5-tf1.8'
pwd=$(pwd)
workspace_mount="$pwd/Workspace"
data_mount="/Data"
keras_data_mount="/Data/keras_datasets"
nvidia-docker run --shm-size=1g \
  --ulimit memlock=-1 \
  --ulimit stack=67108864 \
  --rm -it \
  -v $workspace_mount:/workspace \
  -v $data_mount:/Data \
  -v $keras_data_mount:/root/.keras \
  $docker_repo:$docker_tag
