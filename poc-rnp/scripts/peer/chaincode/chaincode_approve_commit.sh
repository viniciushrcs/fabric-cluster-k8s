export FABRIC_CFG_PATH=$PWD/peer

echo "==== Approving chaincode ===="

peer lifecycle chaincode approveformyorg -n test -v 1.0 -C rnpchannel --sequence 1 --init-required --package-id test.1.0-1.0:c5ceaaab68fedd6e1d8dfed34226d97362506694d089365f9e0030d4a64fa678

echo "==== Checking commit readiness of the chaincode ===="

peer lifecycle chaincode checkcommitreadiness -n test -v 1.0 -C rnpchannel --sequence 1 --init-required

echo "==== Commiting chaincode ===="
peer lifecycle chaincode commit -n test -v 1.0 -C rnpchannel --sequence 1 --init-required

echo "==== Checking commit ===="
peer lifecycle chaincode querycommitted -n test -C rnpchannel