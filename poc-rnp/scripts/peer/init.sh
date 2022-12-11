
WAIT_TIME=5s
ORDERER_ADDRESS="localhost:7050"
export FABRIC_CFG_PATH=$PWD/peer



killall peer


echo "==== Checking if the orderer is running ==="

if pgrep -x "orderer" > /dev/null
then
    echo "==== OK ==="
else
    echo " Orderer is not running. Please launch the Orderer & run init again"
    exit 1
fi

peer node start  &

echo   '==== Creating the channel ===='
bash scripts/peer/create_channel.sh


echo   '==== Waiting for the peer to launch ===='
sleep   $WAIT_TIME


bash scripts/peer/join_channel.sh
killall peer

echo "It is all right! All Steps were executed. You can start the node using the script init.sh"
