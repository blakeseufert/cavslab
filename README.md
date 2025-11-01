```diff
+     █████████                                █████                 █████    
+    ███▒▒▒▒▒███                              ▒▒███                 ▒▒███     
+   ███     ▒▒▒   ██████   █████ █████  █████  ▒███         ██████   ▒███████ 
+  ▒███          ▒▒▒▒▒███ ▒▒███ ▒▒███  ███▒▒   ▒███        ▒▒▒▒▒███  ▒███▒▒███
+  ▒███           ███████  ▒███  ▒███ ▒▒█████  ▒███         ███████  ▒███ ▒███
+  ▒▒███     ███ ███▒▒███  ▒▒███ ███   ▒▒▒▒███ ▒███      █ ███▒▒███  ▒███ ▒███
+   ▒▒█████████ ▒▒████████  ▒▒█████    ██████  ███████████▒▒████████ ████████ 
+    ▒▒▒▒▒▒▒▒▒   ▒▒▒▒▒▒▒▒    ▒▒▒▒▒    ▒▒▒▒▒▒  ▒▒▒▒▒▒▒▒▒▒▒  ▒▒▒▒▒▒▒▒ ▒▒▒▒▒▒▒▒  
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
- Once created, edit the config eg: /etc/pve/lxc/[112].conf
- Add:
```
lxc.cgroup2.devices.allow: c 10:200 rwm
lxc.mount.entry: /dev/net/tun dev/net/tun none bind,create=file
```
*Leave all other as defaults where possible*


#### 2. Add cephfs to LXC on proxmox host referencing the new LXC ID:
```
pct set [[CTID eg:100]] -mp0 /mnt/pve/cephfs/docker,mp=/dockerdata,shared=1

```
#### Run this setup script on the new LXC:

```
apk add curl
curl -fsSL https://raw.githubusercontent.com/blakeseufert/cavslab/refs/heads/main/alpinelxc-setup/alpinelxc-setup.sh | sh

```

----
