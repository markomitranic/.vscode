#!/bin/sh

apt-get install -y unzip git ncdu curl

# Install Docker Engine
# https://docs.docker.com/engine/install/ubuntu/
sudo apt-get update
sudo apt-get install -y ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io

# Install docker-compose
# https://docs.docker.com/compose/install/#install-compose-on-linux-systems
curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Install kubectl 
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux
curl -L "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl
chmod +x /usr/local/bin/kubectl
ln -s /usr/local/bin/kubectl /usr/bin/kubectl

# Install k9s 
# https://github.com/derailed/k9s
curl -L "https://github.com/derailed/k9s/releases/download/v0.25.18/k9s_Linux_x86_64.tar.gz" -o k9s.tar.gz
tar -xvzf k9s.tar.gz
chmod +x k9s
mv ./k9s /usr/local/bin/k9s
ln -s /usr/local/bin/k9s /usr/bin/k9s
rm -rf LICENSE README.md k9s.tar.gz

# Install aws
# https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
curl -L "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
./aws/install --update
rm -rf ./aws ./awscliv2.zip

# Install aws-iam-authenticator
# https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html
curl -L "https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/aws-iam-authenticator" -o /usr/local/bin/aws-iam-authenticator
chmod +x /usr/local/bin/aws-iam-authenticator
ln -s /usr/local/bin/aws-iam-authenticator /usr/bin/aws-iam-authenticator

# Expand File Watchers so VSCode can breathe
# https://code.visualstudio.com/docs/setup/linux#_visual-studio-code-is-unable-to-watch-for-file-changes-in-this-large-workspace-error-enospc
if ! grep -q "fs.inotify.max_user_watches=524288" "/etc/sysctl.conf" ; then
    echo fs.inotify.max_user_watches=524288 | tee -a /etc/sysctl.conf
    sysctl -p
fi