#!/bin/sh
# install docker
sudo apt-get update
sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y
# install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# open docker api port for testing
sudo sed -ie 's/^ExecStart=\/usr\/bin\/dockerd.*$/& -H tcp:\/\/0\.0\.0\.0:4243/g' /lib/systemd/system/docker.service
sudo systemctl daemon-reload
sudo service docker restart

# step 1
# copy /Cloud-Computing/install.sh .
# step 2
# chmod +x install.sh
# step 3
# sudo ./install.sh