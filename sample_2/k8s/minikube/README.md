==================
1. Storage Class
==================
> kubectl apply -f k8s-storage-class.yaml
Para conferir:
> kubectl describe storageclass

==================
2. Criar Orderer
==================
> kubectl apply -f k8s-acme-orderer.yaml
Para conferir:
> kubectl get all
> kubectl logs acme-orderer-0

==================
3. Criar Peer
==================
> kubectl apply -f k8s-acme-peer.yaml
Para conferir:
> kubectl get all
> kubectl logs acme-peer-0



Validate the peer:
> ./cc-test.sh install
> ./cc-test.sh instantiate
> ./cc-test.sh invoke  
> ./cc-test.sh query
> exit

====================
3. Budget Peer Setup
====================
Log into the budget peer:
kubectl exec -it budget-peer-0 sh

Setup the peer:
> ./fetch-channel-block.sh
> ./join-channel.sh

Validate the peer:
./cc-test.sh install
./cc-test.sh query      # This should show the same value for a on both peers
