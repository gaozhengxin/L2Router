const HDWalletProvider = require('@truffle/hdwallet-provider')

const fs = require('fs');
const Web3 = require('web3');

var key = JSON.parse(fs.readFileSync("./key.json") + "");
var pwd = fs.readFileSync("./pwd") + "";
pwd = pwd.trim();

var myveryimportantprivatekey = new Web3().eth.accounts.decrypt(key, pwd).privateKey;

module.exports = {
  contracts_build_directory: './build-ovm',
  networks: {
    boba: {
      provider: function () {
        return new HDWalletProvider({
          privateKey: { myveryimportantprivatekey },
          providerOrUrl: 'http://127.0.0.1:8545'
        })
      },
      network_id: 28,
      host: '127.0.0.1',
      port: 8545,
      gasPrice: 15000000,
    }
  },
  compilers: {
    solc: {
      // Add path to the optimism solc fork
      version: "node_modules/@eth-optimism/solc",
      settings: {
        optimizer: {
          enabled: true,
          runs: 1
        },
      }
    }
  }
}