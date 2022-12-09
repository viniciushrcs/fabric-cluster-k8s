#1.
./clean.sh

BASE_CONFIG_DIR=../../setup/configtx

export FABRIC_CFG_PATH=$PWD

# Change this to see log meesage details
export ORDERER_GENERAL_LOGLEVEL=INFO
WAIT_TIME=3s


#3. Setup cryptogen for 
echo    '================ Generating crypto-config ================'
rm -rf ./crypto-config 2> /dev/null
bash scripts/network_management/generate_certificates.sh

#4. Setup the genesis block
echo    '================ Writing genesis ================'
bash scripts/network_management/generate_genesis_block.sh

#5. Create the acmechannel transaction
echo    '================ Writing rnpchannel ================'
bash scripts/network_management/generate_channel_tx.sh

echo '================ Starting orderer ================'
export FABRIC_CFG_PATH=$PWD/orderer
sleep   $WAIT_TIME
orderer
