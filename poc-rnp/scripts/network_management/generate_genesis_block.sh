export FABRIC_CFG_PATH=$PWD/configtx

configtxgen -outputBlock $FABRIC_CFG_PATH/rnp-genesis.block -profile RnpOrdererGenesis -channelID ordererchannel
