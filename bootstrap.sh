#!/bin/sh

echo "############################################"
echo "###                                     ####"
echo "### Initializing kubernetes cluster     ####"
echo "###                                     ####"
echo "############################################"

. $CNLAB_HOME/.env_sh

# create node using multipass, omit if not required
[[ $create_node = "yes" ]] && multipass launch --name microk8s-vm1 --cpus 4 --mem 16G --disk 100G

snap install microk8s --classic --channel=1.18/stable

# Darwin specific accroding to documentation
[[ $platform = "Darwin" ]] && multipass exec microk8s-vm1 -- sudo iptables -P FORWARD ACCEPT

microk8s status --wait-ready
microk8s enable dns storage metrics-server prometheus ingress dashboard jaeger