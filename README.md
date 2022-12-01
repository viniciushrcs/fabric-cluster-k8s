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

Passo 3) Criar bloco gênesis (orderer channel)

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

## 4) Chaincode

Passo 1) Empacotar o chaincode

- Esse passo é executado após o smart contract já ter sido desenvolvido
- o peer deve estar rodando

`peer lifecycle chaincode package -p path_chaincode --label label_escolhida -l "linguagem_de_programacao"`

Passo 2) Instalar o chaincode no Peer

- o pacote criado é o arquivo tar.gz que foi criado no comando acima

`peer lifecycle chaincode install path_para_o_pacote_criado`

Para confirmar que foi instalado corretamente:

`peer lifecycle chaincode queryinstalled`

` ## Package ID: gocc.1.0-1.0:2009bd5cc8cfb167c1731aff8d22c5584bab3ac407f6b37007afbf4abce2a226, Label: gocc.1.0-1.0`


Passo 3) Aprovação chaincode *Caso necessário aprovação das organizações*

- para uma organização aprovar um chaincode

`peer lifecycle chaincode approveformyorg -n nome_chaincode -v versao_chaincode -C nome_canal --sequence numero_sequencia --init-required --package-id id_pacote_cc`

- para checar se o approve estar pronto para ser commitado

`peer lifecycle chaincode checkcommitreadiness -n nome_chaincode -v versao -C nome_canal --sequence numero_sequencia --init-required`

3.1) Commitar o chaincode

`peer lifecycle chaincode commit -n nome_chaincode -v versao -C nome_canal --sequence numero_sequencia --init-required`

- para checar se foi commitado corretamente

`peer lifecycle chaincode querycommitted -n nome_chaincode -C nome_canal`