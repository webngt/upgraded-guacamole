#!/bin/sh

alias kubectl='multipass exec microk8s-vm1 -- sudo microk8s kubectl'
istio_root=$HOME/projects/istio

cat <<EOF | kubectl create -f -
{
  "apiVersion": "v1",
  "kind": "Namespace",
  "metadata": {
    "name": "bookinfo",
    "labels": {
      "name": "bookinfo",
      "istio-injection": "enabled"
    }
  }
}
EOF

kubectl describe namespace bookinfo

#alias kubectl='multipass exec microk8s-vm1 -- sudo microk8s kubectl -n bookinfo'

cat $istio_root/samples/bookinfo/platform/kube/bookinfo-pod-failure.yaml | kubectl -n bookinfo apply -f -
kubectl -n bookinfo get services
kubectl -n bookinfo get pods

cat $istio_root/samples/bookinfo/networking/bookinfo-gateway.yaml | kubectl -n bookinfo apply -f - 
kubectl -n bookinfo get gateway

cat $istio_root/samples/bookinfo/networking/destination-rule-all-mtls.yaml | kubectl -n bookinfo apply -f -
#kubectl get destinationrules -o yaml

echo "Ingress node port: $(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')"

#watch -n 0.5 curl -o /dev/null -s -w %{http_code} 192.168.64.35:$INGRESS_PORT/productpage
