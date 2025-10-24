#!/usr/bin/env bash

# Read the Rinkeby RPC URL
echo Enter Your Rinkeby RPC URL:
echo Example: "https://eth-rinkeby.alchemyapi.io/v2/XXXXXXXXXX"
read -s rpc

# Read the contract name
echo Which contract do you want to deploy \(eg Greeter\)?
read contract

# Read the constructor arguments
echo Enter constructor arguments separated by spaces \(eg 1 2 3\):
read -ra args

if [ -z "$args" ]
then
  forge create ./src/${contract}.sol:${contract} -i --rpc-url $rpc
else
  forge create ./src/${contract}.sol:${contract} -i --rpc-url $rpc --constructor-args ${args}
fi

Factory
Deployer: 0x330cA32b71b81Ea2b1D3a5C391C5cFB6520E0A10
Deployed to: 0x2a6dD0AE448d7ff534A485Eed2EB66B07c34Bed2
Transaction hash: 0x6ae7c9aaffe2a33d75dd7667ddffc68efaab5ebad7e88081eb4cea807f606ecc
Tx Hash url: https://chainscan-galileo.0g.ai/tx/0x6ae7c9aaffe2a33d75dd7667ddffc68efaab5ebad7e88081eb4cea807f606ecc
Factory Url: https://chainscan-galileo.0g.ai/address/0x2a6dd0ae448d7ff534a485eed2eb66b07c34bed2


Router 
Deployer: 0x330cA32b71b81Ea2b1D3a5C391C5cFB6520E0A10
Deployed to: 0xAfb328dF45DDaa1E8329233D1d9fB528aBCbfD74
Transaction hash: 0x1df39d8ca81200c516d618f33ba1480800bed5caeebfde9aef54e88d869af79d
Tx Hash url: https://chainscan-galileo.0g.ai/tx/0x1df39d8ca81200c516d618f33ba1480800bed5caeebfde9aef54e88d869af79d
Router Url: https://chainscan-galileo.0g.ai/address/0xAfb328dF45DDaa1E8329233D1d9fB528aBCbfD74

