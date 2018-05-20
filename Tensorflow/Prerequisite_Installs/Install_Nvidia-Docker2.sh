#!/bin/bash

#Install prerequisite softwares and docker-ce repository
sudo apt-get install -y ca-certificates curl software-properties-common apt-transport-https
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

#Install docker-ce and nvidia-docker 2
#Note: This process will also install the Docker CE package, since it is a dependency for nvidia-docker. For more installation information, see https://github.com/NVIDIA/nvidia-docker/wiki/Installation-(version-1.0).
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
  sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/ubuntu16.04/amd64/nvidia-docker.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update

sudo apt-get install -y nvidia-docker2
sudo pkill -SIGHUP dockerd

#Allow for maximum resources to be allocated to docker containers
sudo mkdir -p /etc/systemd/system/docker.service.d/
cat <<EOF | sudo tee /etc/systemd/system/docker.service.d/override.conf > /dev/null
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd --default-shm-size="1G" \\
 --host=fd:// \\
 --storage-driver=overlay2
LimitMEMLOCK=infinity
LimitSTACK=67108864
EOF

#Allows docker to be run as a non-root user
sudo groupadd docker
sudo usermod -aG docker $USER

sudo chown "$USER":"$USER" /home/"$USER"/.docker -R
sudo chmod g+rwx "/home/$USER/.docker" -R

#Reboot system for changes to take effect
#Test docker
#docker run --rm hello-world
