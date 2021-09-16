const HDWalletProvider = require('@truffle/hdwallet-provider')

const fs = require('fs');
const Web3 = require('web3');

var key = JSON.parse(fs.readFileSync("./key.json") + "");
var pwd = fs.readFileSync("./pwd") + "";
pwd = pwd.trim();

var myveryimportantprivatekey = new Web3().eth.accounts.decrypt(key, pwd).privateKey;

module.exports = {
  networks: {
    bobatest: {
      provider: function () {
        return new HDWalletProvider([myveryimportantprivatekey], 'https://rinkeby.boba.network');
      },
      network_id: 28,
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
          runs: 200
        },
      }
    }
  }
}