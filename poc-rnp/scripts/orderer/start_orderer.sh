export FABRIC_LOGGING_SPEC=INFO
export ORDERER_FILELEDGER_LOCATION=$PWD/ledgers/orderer/
export FABRIC_CFG_PATH=$PWD/orderer

# Launch the node 
orderer
