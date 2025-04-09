#!/bin/bash

# Update and install dependencies
apt-get update -y
apt-get install -y docker.io git

# Enable Docker and add ubuntu user to docker group
usermod -aG docker ubuntu
systemctl start docker
systemctl enable docker

# Install Docker Compose (v2)
DOCKER_COMPOSE_VERSION="v2.24.5"
mkdir -p /usr/local/lib/docker/cli-plugins
curl -SL https://github.com/docker/compose/releases/download/${DOCKER_COMPOSE_VERSION}/docker-compose-linux-x86_64 \
    -o /usr/local/lib/docker/cli-plugins/docker-compose
chmod +x /usr/local/lib/docker/cli-plugins/docker-compose



# Clone the repo containing docker-compose.yml
git clone https://github.com/AnonyIIMessiah/task-1-workspace.git /home/ubuntu/task-1-workspace

# Navigate to the repo
cd /home/ubuntu/task-1-workspace/terraform_files/jenkins-docker-compose

# Optional: ensure docker-compose.yml is present

    # Run the Jenkins container
sudo docker compose up -d
