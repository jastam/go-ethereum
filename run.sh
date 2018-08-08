#!/bin/sh
set -u
set -e

if [ ! -e /geth.sh ]
then
  echo "Creating account"
  pubkey="3837a575ea779373777f682b26cbb32d3a00d8cb"
  mkdir /datadir
  mkdir /datadir/keystore
  mv /UTC--2018-06-13T08-21-07.573900500Z--${pubkey} /datadir/keystore/UTC--2018-06-13T08-21-07.573900500Z--${pubkey}

  echo "Writing genesis.json"
  sed -e s/##address##/${pubkey}/g /genesis.json.template > /genesis.json

  echo "Initializing new blockchain"
  geth --datadir /datadir init /genesis.json

  echo "Writing start script"
  echo "exec geth --datadir /datadir --nousb --networkid 2814 --syncmode 'full' --gcmode 'archive' --identity '${HOSTNAME}' --ws --wsapi 'admin,debug,eth,miner,net,personal,shh,txpool,web3' --wsaddr '0.0.0.0' --wsorigins '*' --ipcdisable --shh --mine --minerthreads 1 --targetgaslimit 0 --gasprice '1' --unlock '0x${pubkey}' --password /accountpswd.txt" > /geth.sh
  chmod +x /geth.sh
fi

echo "starting geth"
exec /geth.sh
