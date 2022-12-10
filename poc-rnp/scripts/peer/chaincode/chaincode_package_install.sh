
export FABRIC_LOGGING_SPEC=INFO
export CORE_PEER_FILESYSTEMPATH=$PWD/ledgers/peer
export CORE_PEER_MSPCONFIGPATH=$PWD/crypto-config/peerOrganizations/rnp.com/users/Admin@rnp.com/msp
export FABRIC_CFG_PATH=$PWD/peer

echo "==== Packaging chaincode ===="

peer lifecycle chaincode package $PWD/packages/test.1.0-1.0.tar.gz -p $PWD/packages/chaincode_example02 --label test.1.0-1.0 -l "node" 

echo "==== Installing chaincode ===="

peer lifecycle chaincode install  $PWD/packages/test.1.0-1.0.tar.gz

echo "==== Checking installation chaincode ===="

peer lifecycle chaincode queryinstalled