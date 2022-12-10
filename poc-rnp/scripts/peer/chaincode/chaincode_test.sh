export CORE_CHAINCODE_LOGGING_LEVEL=INFO
export FABRIC_CFG_PATH=$PWD/peer


peer chaincode invoke  -C rnpchannel -n test  -c '{"Args":["invoke","b","a","5"]}'
peer chaincode query -C rnpchannel -n test  -c '{"Args":["query","a"]}'