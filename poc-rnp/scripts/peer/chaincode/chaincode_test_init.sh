export CORE_CHAINCODE_LOGGING_LEVEL=INFO
export FABRIC_CFG_PATH=$PWD/peer


peer chaincode invoke --isInit -n test -C rnpchannel -c'{"Args":["init", "a", "100", "b", "300"]}'

