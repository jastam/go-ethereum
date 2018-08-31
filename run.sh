#!/bin/sh
set -u
set -e


pubkey="88e94a4b7bfc62a38d300d98ce1c09f30fb75e3e"

if [ ! -e /external/datadir ]
then
  echo "Creating account"
  mkdir /external/datadir
  mkdir /external/datadir/keystore
  mv /UTC--2018-06-13T08-21-07.573900500Z--${pubkey} /external/datadir/keystore/UTC--2018-06-13T08-21-07.573900500Z--${pubkey}

  echo "Writing genesis.json"
  sed -e s/##address##/${pubkey}/g /genesis.json.template > /genesis.json

  echo "Initializing new blockchain"
  geth --datadir /external/datadir init /genesis.json
fi

echo "starting geth"

exec geth --datadir /external/datadir --nousb --networkid 2814 --syncmode 'full' --gcmode 'archive' --identity "${HOSTNAME}" --ws --wsapi 'admin,debug,eth,miner,net,personal,shh,txpool,web3' --wsaddr '0.0.0.0' --wsorigins '*' --rpc --rpcaddr '0.0.0.0' --rpcapi 'admin,debug,eth,miner,net,personal,shh,txpool,web3' --ipcdisable --shh --mine --minerthreads 1 --gasprice '1' --targetgaslimit 1203200000 --unlock "0x${pubkey}" --password /accountpswd.txt
