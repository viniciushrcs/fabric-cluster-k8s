export FABRIC_CFG_PATH=$PWD/peer
export CONFIG_DIRECTORY=$PWD/configtx
export CORE_PEER_MSPCONFIGPATH=$PWD/crypto-config/peerOrganizations/rnp.com/users/Admin@rnp.com/msp

ORDERER_ADDRESS="localhost:7050"

echo   'Creating the channel: rnpchannel - may fail if already created'
peer channel create -o $ORDERER_ADDRESS -c rnpchannel -f $CONFIG_DIRECTORY/rnp-create-channel.tx --outputBlock="$FABRIC_CFG_PATH/rnpchannel.block"