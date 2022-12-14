# Removes components generated by orderer

# Kills the orderer process if its running
killall orderer  2> /dev/null


# Delete the data folders created by the orderer

# IF YOU CHANGE THE LOCATION OF FileLedger - UPDATE This in accordance with
# what you have in the launch.sh script
rm -rf $PWD/ledgers/orderer/*
rm ./trace/*  2> /dev/null
rm -rf ./temp  2> /dev/null

if [ -z $1 ];
then
    echo 'Deleted the ledger data only.'
    echo 'To delete all artifacts use:  ./clean.sh  all'
    exit 0;
fi

# Remove the network artifacts
if [ $1 = 'all' ] 
then
    bash scripts/network_management/clean_all.sh 
    echo 'Deleted all artifacts.'
else
    echo 'Deleted the ledger data only.'
    echo 'To delete all artifacts use:  ./clean.sh  all'
fi
