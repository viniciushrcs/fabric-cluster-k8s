
WAIT_TIME=5s
ORDERER_ADDRESS="localhost:7050"
export FABRIC_CFG_PATH=$PWD/peer
export CORE_PEER_MSPCONFIGPATH=$PWD/crypto-config/peerOrganizations/rnp.com/users/Admin@rnp.com/msp


killall peer


echo "==== Checking if the orderer is running ==="

if pgrep -x "orderer" > /dev/null
then
    echo "==== OK ==="
else
    echo " Orderer is not running. Please launch the Orderer & run init again"
    exit 1
fi


echo   '==== Creating the channel ===='
bash scripts/peer/create_channel.sh


peer node start  &


echo   '==== Waiting for the peer to launch ===='
sleep   $WAIT_TIME


bash scripts/peer/join_channel.sh

sleep   $WAIT_TIME

echo   'Kill all the peer process'
killall peer

echo "It is all right! All Steps were executed."

echo "Now you can Launch Peer using ./start-node.sh"