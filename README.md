# .vscode Dotfile for CND

A sample dotfile that serves as an umbrella VSCode project when working on a remote host.

If you connect via SSH, VSC will ask you to open a project or a file, and you would open this one. It will set up recommended extensions and default settings values. It does not contain any language servers or coding support.

- [.vscode Dotfile for CND](#vscode-dotfile-for-cnd)
- [Using the workbox, day-to-day](#using-the-workbox-day-to-day)
- [First time Connecting VSCode](#first-time-connecting-vscode)
- [Using VirtualBox as a VM](#using-virtualbox-as-a-vm)
- [Using DigitalOcean as a VM](#using-digitalocean-as-a-vm)
	- [Provisioning Infrastructure](#provisioning-infrastructure)
	- [Moving to a new machine](#moving-to-a-new-machine)
# Using the workbox, day-to-day
Open VSCode and connect in one of the three ways:

1. If it was your last open window, it will automatically reconnect.
2. From the menu File > Open Recent.
3. `Cmd + Shift + P` and type "Remote-SSH: Connect to Remote Host"

For more usage examples and videos, read [my article](https://medium.com/homullus/remote-development-or-how-i-learned-to-stop-worrying-and-love-the-mainframe-90165147a57d#fde9)

# First time Connecting VSCode
1. Clone the VSCode project settings repository. 
   ```bash
   ssh workbox
   git clone git@github.com:markomitranic/.vscode.git /home/vagrant/projects/.vscode
   ```
2. Start VSCode on the host machine.
3. Install dependencies:
   1. `Cmd+Shift+P` and type "install remote development"
   2. Install plugins `Remote - Containers` and `Remote - SSH`.
4. Connect to the VM:
   1. `Cmd+Shift+P` and type "Remote-SSH: Connect to Remote Host"
   2. Pick `workbox` from the list.
5. Open workspace:
   1. `Cmd+Shift+P` and type "open workspace from file"
   2. Locate the file `/home/vagrant/projects/.vscode/workspace.code-workspace`
6. Install recomended extensions
   1. `Cmd+Shift+P` and type "Extensions: Show Recommended Extensions"
   2. Click on the little cloud symbol.

# Using VirtualBox as a VM

Follow the directions in the VBox repository.

# Using DigitalOcean as a VM

## Provisioning Infrastructure
- create a droplet workspace
	- give it workspace tag
	- set up floating IP
	- add IP to your hosts file
- Firewall (optional, recommended):
    - spawn a VPN droplet
        - Marketplace Image: `OpenVPN + Pihole`
        - in the same VPC
    	- name `openvpn-pihole`, tag `vpn`
    	- Follow the getting started directions
    	- Add your new floating IP to the VPN conf (last line of config) to route only that IP.
			```none
			route-nopull
			route 178.122.131.139 255.255.255.255
			```
    - create a Network Firewall
        - name workspace
        - IN: allow [`ICMP`, `TCP`, `UDP`] from `vpn` tag.
        - OUT: allow [`ICMP`, `TCP`, `UDP`] from [`All IPv4`, `All IPv6`].
## Moving to a new machine
- add a disk to droplet named workspace
  - cp -R /root/workspace /mnt/workspace/
  - power down the machine
  - detach the volume and the floating IP
- create and provision a new droplet as seen above
  - cp -R /mnt/workspace/workspace /root/
- detach and destroy the volume