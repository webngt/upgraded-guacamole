#!/bin/sh

alias kubectl='multipass exec microk8s-vm1 -- sudo microk8s kubectl'

kubectl delete namespace bookinfo
