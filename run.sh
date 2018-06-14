#!/bin/sh
set -u
set -e

if [ ! -e /datadir ]
then
  echo "Writing genesis.json"
  sed -e s/##address##/${pubkey}/g /genesis.json.template > /genesis.json

  echo "Initializing new blockchain"
  geth --datadir /datadir init /genesis.json

  echo "exec " > /geth.sh
fi

echo "starting geth"
exec geth --datadir /datadir --keystore /keystore --nousb --networkid 2814 --syncmode 'full' --gcmode 'archive' --identity "${HOSTNAME}" --ws --wsapi 'admin,debug,eth,miner,net,personal,shh,txpool,web3' --wsaddr '0.0.0.0' --wsorigins '*' --ipcdisable --mine --minerthreads 1 --targetgaslimit 0 --gasprice '1' --unlock "0x${pubkey}" --password /run/secrets/geth_key_pswd
