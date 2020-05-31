#!/bin/sh

# apply dashboard certs
cat <<EOF | multipass exec microk8s-vm1 -- sudo microk8s kubectl -n kube-system apply -f -
apiVersion: v1
data:
  dashboard.crt: $(cat ca/dashboard.cnlab.crt | base64)
  dashboard.key: $(cat ca/dashboard.cnlab.key | base64)
kind: Secret
metadata:
  creationTimestamp: null
  name: kubernetes-dashboard-certs
  namespace: kube-system
EOF

# reload dashboard to ensure certs are effective
multipass exec microk8s-vm1 -- sudo microk8s kubectl -n kube-system delete pod -l k8s-app=kubernetes-dashboard

token=$(multipass exec microk8s-vm1 -- sudo microk8s kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)
multipass exec microk8s-vm1 -- sudo microk8s kubectl -n kube-system describe secret $token