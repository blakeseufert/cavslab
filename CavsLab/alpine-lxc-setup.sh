#!/bin/sh

YELLOW='\e[33m'
NC='\e[0m'

echo -e ${YELLOW}"
   █████████                                █████                 █████    
  ███▒▒▒▒▒███                              ▒▒███                 ▒▒███     
 ███     ▒▒▒   ██████   █████ █████  █████  ▒███         ██████   ▒███████ 
▒███          ▒▒▒▒▒███ ▒▒███ ▒▒███  ███▒▒   ▒███        ▒▒▒▒▒███  ▒███▒▒███
▒███           ███████  ▒███  ▒███ ▒▒█████  ▒███         ███████  ▒███ ▒███
▒▒███     ███ ███▒▒███  ▒▒███ ███   ▒▒▒▒███ ▒███      █ ███▒▒███  ▒███ ▒███
 ▒▒█████████ ▒▒████████  ▒▒█████    ██████  ███████████▒▒████████ ████████ 
  ▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒▒    ▒▒▒▒▒    ▒▒▒▒▒▒  ▒▒▒▒▒▒▒▒▒▒▒  ▒▒▒▒▒▒▒▒ ▒▒▒▒▒▒▒▒  

${NC}"
echo -e  "
${YELLOW}--- Alpine LXC setup script. Includes Docker, Tailscale & Utils ---${NC}" 
echo -e "${YELLOW}--- Connects to cephfs share /dockerdata/${NC}
"                                                                          
                                                                           
# Update package lists and install all required utilities and services.
echo -e "
${YELLOW}---Updating package list and installing packages...${NC}
" 
apk update
apk add docker || true
apk add tailscale || true
apk add btop || true
apk add nano || true 
apk add openssh || true
apk add util-linux || true 
apk add docker-cli-compose || true
apk add neofetch || true

# ---
# Configure Services to Start at Boot (OpenRC)
# ---

echo -e "
${YELLOW}---Enabling services to start at boot (docker, tailscale, sshd)...${NC}
" 

# 1. Enable and start the Docker service
rc-update add docker default
rc-service docker start

# 2. Enable and start the SSH daemon
rc-update add sshd default
rc-service sshd start

# 3. Enable the Tailscale service to run at boot
rc-update add tailscale default
rc-service tailscale start

# This Tailscale setup process.
echo -e "${YELLOW}
---Setup Tailscale tun userspace-networking...${NC}
" 
echo 'TAILSCALED_OPTS="--tun=userspace-networking"' >> /etc/conf.d/tailscale
echo -e "
---${YELLOW}Starting Tailscale interactive setup...${NC}
" 
tailscale up --ssh --force-reauth

echo -e "${YELLOW} 
* Remember to: 
- Connect Tailscale (above URL)
- Connect cephfs share as a mountpoint for the LXC on proxmox
  - pct set [[CTID eg:100]] -mp0 /mnt/pve/cephfs/docker,mp=/dockerdata,shared=1
- Setup Swarm
- Reboot
✅ Done! ${NC}
"

sleep 1
