Setup LXC on Alpine:

```
curl -fsSL https://raw.githubusercontent.com/blakeseufert/homelab/refs/heads/main/CavsLab/alpine-lxc-setup.sh | sh
```

----
Don't forget to set this on the proxmox host referencing the new LXC:
```
pct set [[CTID eg:100]] -mp0 /mnt/pve/cephfs/docker,mp=/dockerdata,shared=1
```
