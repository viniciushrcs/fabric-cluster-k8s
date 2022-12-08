export FABRIC_CFG_PATH=$PWD/configtx

configtxgen -outputCreateChannelTx $FABRIC_CFG_PATH/rnp-create-channel.tx -profile RnpChannel -channelID rnpchannel