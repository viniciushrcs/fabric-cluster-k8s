
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

4. Colocar acme-peer no canal

> kubectl exec -it acme-peer-0 sh
> ./submit-channel-create.sh
> peer channel list 
> ./join-channel.sh
> peer channel list 

----------------

5. Rodar Chaincode

> ./cc-test.sh install
> ./cc-test.sh instantiate
> ./cc-test.sh invoke  
> ./cc-test.sh query
> exit

---------

6. Adicionar outra organização no canal

> kubectl apply -f k8s-budget-peer.yaml
> kubectl exec -it budget-peer-0 sh
> ./fetch-channel-block.sh
> ./join-channel.sh

>./cc-test.sh install
>./cc-test.sh query
