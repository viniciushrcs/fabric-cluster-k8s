export FABRIC_CFG_PATH=$PWD/peer
export CONFIG_DIRECTORY=$PWD/configtx

ORDERER_ADDRESS="localhost:7050"

echo   '======== Joining channel ========'
peer channel join -o localhost:7050 -b $FABRIC_CFG_PATH/rnpchannel.block

echo   '====== Listing channel joined ========'
peer channel list