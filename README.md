```
   █████████                                █████                 █████    
  ███▒▒▒▒▒███                              ▒▒███                 ▒▒███     
 ███     ▒▒▒   ██████   █████ █████  █████  ▒███         ██████   ▒███████ 
▒███          ▒▒▒▒▒███ ▒▒███ ▒▒███  ███▒▒   ▒███        ▒▒▒▒▒███  ▒███▒▒███
▒███           ███████  ▒███  ▒███ ▒▒█████  ▒███         ███████  ▒███ ▒███
▒▒███     ███ ███▒▒███  ▒▒███ ███   ▒▒▒▒███ ▒███      █ ███▒▒███  ▒███ ▒███
 ▒▒█████████ ▒▒████████  ▒▒█████    ██████  ███████████▒▒████████ ████████ 
  ▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒▒    ▒▒▒▒▒    ▒▒▒▒▒▒  ▒▒▒▒▒▒▒▒▒▒▒  ▒▒▒▒▒▒▒▒ ▒▒▒▒▒▒▒▒  
```

# Homelab Config Files

## Setup Alpine Linux on LXC as docker swarm hosts:
----

#### 1. Setup for LXC container  
- Use 90+% of host resources (cpu, mem, disk). 
- Naming convention is [uniquenamne]-[px-hostname]. This is because these containers never to HA as swarm does this for us.
- no SSH key (use tailscale for this)
- Use Alpine latest. 3.22 has been tested as working.
- Add disk to cephpool @ 100gb size
- Network set DHCP
*Leave all other as defaults where possible*


#### 2. Run this on proxmox host referencing the new LXC ID:
```
pct set [[CTID eg:100]] -mp0 /mnt/pve/cephfs/docker,mp=/dockerdata,shared=1

```
#### Run this setup script on the new LXC:

```
apk add curl
curl -fsSL https://raw.githubusercontent.com/blakeseufert/homelab/refs/heads/main/CavsLab/alpine-lxc-setup.sh | sh

```

----
