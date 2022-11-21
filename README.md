# fabric-cluster-k8s

1. Criar Volumes Persistentes

- Para testes, criar o caminho "/mnt/data" dentro do worker node (no caso de minikube rodando com apenas 1 node)
  `minikube ssh`
  `mkdir /mnt/data`

- aplicar o PV e PVC no k8s

`kubectl apply -f pv.yaml`
`kubectl apply -f pvc.yaml`

2. Mover pasta `prerequisite` para o caminho onde está o Volume

`scp -i (path com o id do minikube)~/.minikube/machines/minikube/id_rsa -r -P (porta mapeada para a porta 22) 49748 (caminho da pasta prerequisite)/prerequisite/* docker@127.0.0.1:.`

3. Start no Fabric CA Server

- criar pasta `organizations` dentro do PV
- transferir a pasta `fabric-ca` para dentro de organizations
  - dentro do node `mv /home/docker/fabric-ca /mnt/data/organizations`
- aplicar os arquivos yaml para cada CA de cada organização
  - 1 Deployment
  - 1 Service

4. Gerar os certificados

- aplicar o `certificates/job.yaml`

5. Gerar os artefatos de configuração

- aplicar o `artifacts/job.yaml`

6. Iniciar o Ordering Service

- aplicar os arquivos dentro da pasta `/orderer/`

7. Iniciar os Peers

- aplicar o objeto `configmap/builder-config`
- aplicar todos os objetos dentro da pasta `peers`
