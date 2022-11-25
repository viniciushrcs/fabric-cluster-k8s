
1. Storage Class

> kubectl apply -f k8s-storage-class.yaml
Para conferir:
> kubectl describe storageclass

----------------

2. Criar Orderer

> kubectl apply -f k8s-acme-orderer.yaml
Para conferir:
> kubectl get all
> kubectl logs acme-orderer-0

----------------

3. Criar Peer

> kubectl apply -f k8s-acme-peer.yaml
Para conferir:
> kubectl get all
> kubectl logs acme-peer-0

----------------

Validate the peer:
> ./cc-test.sh install
> ./cc-test.sh instantiate
> ./cc-test.sh invoke  
> ./cc-test.sh query
> exit

