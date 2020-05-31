#!/bin/sh

alias kubectl='multipass exec microk8s-vm1 -- sudo microk8s kubectl'


ingress_port=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
multipass exec microk8s-vm1 -- watch -n 0.5 curl -o /dev/null -s -w %{http_code} 192.168.64.35:$ingress_port/productpage