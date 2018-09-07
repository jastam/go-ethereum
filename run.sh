#!/bin/sh
set -u
set -e

if [ ! -e /external/datadir ]
then
  echo "Initializing blockchain"
  geth --datadir /external/datadir init /rinkeby.json
fi

echo "starting geth"

exec geth --datadir /external/datadir --nousb --networkid 4 --cache=512 --ws --wsapi 'admin,debug,eth,miner,net,personal,shh,txpool,web3' --wsaddr '0.0.0.0' --wsorigins '*' --rpc --rpcaddr '0.0.0.0' --rpcapi 'admin,debug,eth,miner,net,personal,shh,txpool,web3' --shh --bootnodes enode://a24ac7c5484ef4ed0c5eb2d36620ba4e4aa13b8c84684e1b4aab0cebea2ae45cb4d375b77eab56516d34bfbd3c1a833fc51296ff084b770b94fb9028c4d25ccf@52.169.42.101:30303,enode://343149e4feefa15d882d9fe4ac7d88f885bd05ebb735e547f12e12080a9fa07c8014ca6fd7f373123488102fe5e34111f8509cf0b7de3f5b44339c9f25e87cb8@52.3.158.184:30303,enode://b6b28890b006743680c52e64e0d16db57f28124885595fa03a562be1d2bf0f3a1da297d56b13da25fb992888fd556d4c1a27b1f39d531bde7de1921c90061cc6@159.89.28.211:30303
