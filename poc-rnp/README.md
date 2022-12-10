
# fabric-bootstrap com scripts shell

- todos os scripts devem ser executados a partir da pasta poc-rnp

Passo 1) Autenticar no terminal

- autenticação no terminal
`su - @usuário`

Passo 2) Iniciar o Orderer da primeira vez (irá gerar os certificados, genesis_block, e create_channel tx)

`bash scripts/orderer/init.sh`

- após a execução do script acima, para iniciar novamente o Orderer basta rodar o script `start_orderer.sh` e para terminá-lo `stop_orderer.sh`

Passo 3) Peer

- Em outro terminal

`su - @usuario`

`bash scripts/peer/init.sh`

- após a execução do script acima, para iniciar novamente o Peer basta rodar o script `start_node.sh` e para terminá-lo `stop_node.sh`

Passo 4) Chaincode

- Em outro terminal

`su - @usuario`

`bash scripts/peer/chaincode/chaincode_package_install.sh`
`bash scripts/peer/chaincode/chaincode_approve_commit.sh`
`bash scripts/peer/chaincode/chaincode_test_init.sh`
`bash scripts/peer/chaincode/chaincode_test.sh `

------

# fabric-bootstrap binários

## 1) Configuração da rede

Passo 1) Criar Identidades e MSPs
- entrar na pasta /poc-rnp/  
- criar arquivo crypto-config.yaml
- Rodar o comando `cryptogen generate --config=./cryptogen/crypto-config.yaml`

Passo 2) Criar bloco gênesis (orderer channel)

- entrar na pasta configtx
- rodar os comandos:
`export FABRIC_CFG_PATH=$PWD`
`configtxgen -outputBlock rnp-genesis.block -profile RnpOrdererGenesis -channelID ordererchannel`

Passo 3) Criar a transação Create Channel Transaction

`configtxgen -outputCreateChannelTx rnp-create-channel.tx -profile RnpChannel -channelID rnpchannel`

## 2) Orderer

Passo 4) Iniciar o Orderer
- Entrar na pasta orderer

`export ORDERER_FILELEDGER_LOCATION=../ledgers/orderer/`

`export FABRIC_LOGGING_SPEC=INFO`

`export FABRIC_CFG_PATH=$PWD`

`orderer`


## 3) Peer

Passo 5) Iniciar o peer

`export FABRIC_CFG_PATH=$PWD`
`peer node start`

Passo 6) Criar o Channel

- com o orderer rodando e o peer rodando, abrir um novo terminal
- neste novo terminal, entrar na pasta peer

- `peer channel create -o localhost:7050 -c rnpchannel -f ../configtx/rnp-create-channel.tx`

Passo 7) Entrar no Channel

- `peer channel join -o localhost:7050 -b ./rnpchannel.block`

Para conferir, rodar o comando `peer channel list` que deve retornar os channels que o peer entrou

## 4) Chaincode

Passo 8) Empacotar o chaincode

- com o peer e orderer rodando, em um outro terminal, executar na pasta peer

`peer lifecycle chaincode package ../packages/test.1.0-1.0.tar.gz -p ../packages/chaincode_example02 --label test.1.0-1.0 -l "node"`

Passo 9) Instalar o chaincode no Peer

- o pacote criado é o arquivo tar.gz que foi criado no comando acima

`peer lifecycle chaincode install ../packages/test.1.0-1.0.tar.gz`

Para confirmar que foi instalado corretamente:

`peer lifecycle chaincode queryinstalled`

` ## Package ID: test.1.0-1.0:3d84c73241e5fd7d07506bfee361b49165c136d8781c6bd444197df9c494c4bf, Label: test.1.0-1.0`


Passo 10) Aprovação chaincode 

- para uma organização aprovar um chaincode

`peer lifecycle chaincode approveformyorg -n test -v 1.0 -C rnpchannel --sequence 1 --init-required --package-id test.1.0-1.0:3d84c73241e5fd7d07506bfee361b49165c136d8781c6bd444197df9c494c4bf`

- para checar se o approve estar pronto para ser commitado

`peer lifecycle chaincode checkcommitreadiness -n test -v 1.0 -C rnpchannel --sequence 1 --init-required`

```## Chaincode definition for chaincode 'test', version '1.0', sequence '1' on channel 'rnpchannel' approval status by org: Org1MSP: true``` 

Passo 11) Commitar o chaincode

`peer lifecycle chaincode commit -n test -v 1.0 -C rnpchannel --sequence 1 --init-required`

- para checar se foi commitado corretamente

`peer lifecycle chaincode querycommitted -n test -C rnpchannel`

Passo 4) Inicializar chaincode

`peer chaincode invoke --isInit -n test -C rnpchannel -c'{"Args":["init", "a", "100", "b", "300"]}'`

Passo 5) Query chaincode

`peer chaincode query -C rnpchannel -n test -c '{"Args":["query","a"]}'`

Passo 6) Invocar chaincode

`peer chaincode invoke -n test -C rnpchannel -c '{"Args": ["invoke", "a", "b", "20"]}'`
