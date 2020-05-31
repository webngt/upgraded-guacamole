#!/bin/sh

# vm2
multipass launch --name microk8s-vm2 --cpus 2 --mem 4G --disk 40G
multipass exec microk8s-vm2 -- sudo snap install microk8s --classic --channel=1.18/stable
multipass exec microk8s-vm2 -- sudo iptables -P FORWARD ACCEPT
multipass exec microk8s-vm2 -- sudo microk8s status --wait-ready

# vm3
multipass launch --name microk8s-vm3 --cpus 2 --mem 4G --disk 40G
multipass exec microk8s-vm3 -- sudo snap install microk8s --classic --channel=1.18/stable
multipass exec microk8s-vm3 -- sudo iptables -P FORWARD ACCEPT
multipass exec microk8s-vm3 -- sudo microk8s status --wait-ready