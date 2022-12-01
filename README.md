# fabric-bootstrap

## 0) Pré-requerimentos:
1) Docker
2) Go
3) Binários do Fabric
	-  Peer
	-  Orderer
4) jq
5) CA Server
6) CA client

---
## 1) Configuração da rede

Passo 1) Criar o arquivo `configtx.yaml`

- arquivo com 6 seções que contém as configurações da rede
	- Organizações 
	- Orderer
	- Channel
	- Application
	- Capabilities
	- Profiles

Passo 2) Criar Identidades e MSPs
**WIP**

- criar arquivo crypto-config.yaml 
- Rodar o comando `cryptogen generate --config=./cryptogen/crypto-config.yaml`

Passo 3) Criar bloco gênesis

`export FABRIC_CFG_PATH=$PWD`
`configtxgen -outputBlock nome_arquivo_output -profile nome_da_seção -channelID nome_do_canal`

Passo 4) Criar a transação Create Channel Transaction

`configtxgen -outputCreateChannelTx nome_arquivo_output -profile nome_da_seção -channelID nome_do_canal`

## 2) Orderer

Paso 5) Criar o arquivo com configurações do Orderer, `orderer.yaml`
- Seções + importantes:
	- General
	- FileLedger: Local no Filesystem onde o Orderer irá persistir o Ledger
	- Consensus: Usado para gerenciar armazenamento quando o tipo de consenso é RAFT
	- Operations

Passo 6) Iniciar o Orderer
- Existem 2 formas de iniciar o Orderer (1) com o System Channel e (2) sem o mesmo.
	- Para criar com o System Channel, é necessário passar o Genesis Block como input. (path passado no arquivo `orderer.yaml`, seção General.BootstrapFile)

`export ORDERER_FILELEDGER_LOCATION=path do diretorio que irá salvar o ledger`

`export FABRIC_LOGGING_SPEC=INFO
`
`FABRIC_CFG_PATH` = path do `orderer.yaml`

`orderer`


## 3) Peer

Passo 7) Criar o arquivo com configurações do Peer, `core.yaml`

colocar o local onde será salvo o ledger do peer
- fileSystemPath: /home/viniciushrcs/vini_projects/fabric-cluster-k8s/poc-rnp/ledgers/peer

colocar o local com as credenciais do Admin
- mspConfigPath: ../crypto-config/peerOrganizations/rnp.com/users/Admin@rnp.com/msp

Passo 8) Iniciar o Peer

`peer node start`

Passo 9) Criar o Channel

- O orderer precisa estar rodando
- `peer channel create -o localhost:7050 -c nome_do_canal -f path_do_arquivo_de_criacao_do_channel`

Passo 10) Entrar no Channel

- `peer channel join -o localhost:7050 -b caminho_do_arquivo_com_bloco_inicial_do_channel`

Para conferir, rodar o comando `peer channel list` que deve retornar os channels que o peer entrou

## 4) Smart contracts

**TBD**
