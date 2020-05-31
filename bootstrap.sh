#!/bin/sh

# master node
multipass launch --name microk8s-vm1 --cpus 4 --mem 16G --disk 100G
multipass exec microk8s-vm1 -- sudo snap install microk8s --classic --channel=1.18/stable
multipass exec microk8s-vm1 -- sudo iptables -P FORWARD ACCEPT
multipass exec microk8s-vm1 -- sudo microk8s status --wait-ready
multipass exec microk8s-vm1 -- sudo microk8s enable dns storage metrics-server prometheus ingress dashboard jaeger