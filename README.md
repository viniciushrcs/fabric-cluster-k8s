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

**TBD**

Passo 3) Criar bloco gênesis

`configtxgen -outputBlock=nome_arquivo_output -profile=nome_da_seção -channelId=nome_do_canal`

Passo 4) Criar a transação Create Channel Transaction

`configtxgen -outputCreateChannelTx=nome_arquivo_output -profile=nome_da_seção -channelId=nome_do_canal`

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

`FABRIC_CFG_PATH` = path do `orderer.yaml`
`orderer start`

## 3) Peer

Passo 7) Criar o arquivo com configurações do Peer, `core.yaml`

Passo 8) Iniciar o Peer

`peer node start`

## 4) Smart contracts

**TBD**
