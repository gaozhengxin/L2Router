// truffle-config-ovm.js
const HDWalletProvider = require('@truffle/hdwallet-provider')
const fs = require('fs');
var Web3 = require('web3');

var key = fs.readFileSync("./key.json");
var pwd = fs.readFileSync("./pwd");

const { default: Wallet } = require('ethereumjs-wallet')

async function convert(str, pass) {
    const saleWallet = Wallet.fromEthSale(str, pass)
    const v3Wallet = await saleWallet.toV3(pass)
    console.log(v3Wallet)
}

var privatekey = convert(key, pwd)

module.exports = {
  networks: {
    opkovan: {
      network_id: 69,
      gas: 15000000,
      provider: function() {
        return new HDWalletProvider({
          privateKeys: [privatekey],
          providerOrUrl: "https://kovan.optimism.io",
          chainId: 69
        })
      }
    }
  },
  compilers: {
    solc: {
      version: "node_modules/@eth-optimism/solc",
      settings: {          // See the solidity docs for advice about optimization and evmVersion
        optimizer: {
          enabled: true,
          runs: 200
        },
      }
    }
  }
};
