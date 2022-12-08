# Launches the peer process

# Set the environment variables for overriding the config in core.yaml

# export CORE_LOGGING_LEVEL=DEBUG
export FABRIC_LOGGING_SPEC=INFO
export CORE_PEER_FILESYSTEMPATH=$PWD/ledgers/peer

# Launch the peer with Peer's Identity/MSP
export CORE_PEER_MSPCONFIGPATH=$PWD/crypto-config/peerOrganizations/rnp.com/users/Admin@rnp.com/msp

export FABRIC_CFG_PATH=$PWD/peer

# Launch the node 
peer node start
