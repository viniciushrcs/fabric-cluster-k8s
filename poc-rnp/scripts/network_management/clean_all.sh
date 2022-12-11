echo "===== Cleaning artifacts ... ======"
export  CONFIG_DIRECTORY=$PWD/configtx

echo "===== Cleaning configtx/*.tx ======"

rm $CONFIG_DIRECTORY/*.tx  2> /dev/null

echo "===== Cleaning configtx/*.block ======"

rm $CONFIG_DIRECTORY/*.block  2> /dev/null

echo "===== Cleaning peer/*.block ======"

rm $CONFIG_DIRECTORY/../peer/*.block  2> /dev/null

echo "===== Cleaning crypto-config ======"

rm -rf $CONFIG_DIRECTORY/../crypto-config 2> /dev/null

echo "===== Cleaning orderer ledger ======"

rm -rf $CONFIG_DIRECTORY/../ledgers/orderer/* 2> /dev/null

echo "===== Cleaning peer ledger ======"

rm -rf $CONFIG_DIRECTORY/../ledgers/peer/* 2> /dev/null

echo "===== Cleaning chaincode ======"

rm -rf $CONFIG_DIRECTORY/../packages/*.tar.gz 2> /dev/null

echo "Done."