# .vscode Dotfile for CND

**TODO: this whole file**

# Brand new install

## Infrastructure
- create a droplet workspace
	- give it workspace tag
	- set up floating IP
	- add IP to your hosts file

## Provisioning
- update & upgrade
	- [Install Docker CE](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository)
	- [Install docker-compose](https://docs.docker.com/compose/install/#install-compose-on-linux-systems)
	- [Install Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#install-kubectl-binary-with-curl-on-linux)
	- [Install k9s](https://github.com/derailed/k9s)
	- [Install aws](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
	- [Install aws-iam-authenticator](https://docs.aws.amazon.com/eks/latest/userguide/install-aws-iam-authenticator.html)
	- Install `apt-get install -y ncdu unzip`
    - [set file watchers](https://code.visualstudio.com/docs/setup/linux#_visual-studio-code-is-unable-to-watch-for-file-changes-in-this-large-workspace-error-enospc) because vscode needs em
	- clone git repo to /mnt/workspace/.vscode

## Connecting VSCode
- start local vscode
	- "install remote development"
	- "Remote-SSH: Connect to Remote Host"
	- "open workspace from file" /mnt/workspace/.vscode/workspace.code-workspace
	- "Extensions: Show Recommended Extensions" click on the little cloud symbol
	- thas it

# Cleaning up from time to time
- `docker system prune --all`
- `docker volume rm $(docker volume ls)`
- delete vendors
	```bash
	find . -type d -name node_modules -prune -exec rm -rf {} \;
	find . -type d -name .venv -prune -exec rm -rf {} \;
	find . -type d -name .tmp -prune -exec rm -rf {} \;
	find . -type d -name .vscode-server -prune -exec rm -rf {} \;
	```
- `ncdu /`

# Moving to a new machine
- add a disk to droplet named workspace
  - cp -R /root/workspace /mnt/workspace/
  - power down the machine
  - detach the volume and the floating IP
- create and provision a new droplet as seen above
  - cp -R /mnt/workspace/workspace /root/
- detach and destroy the volume