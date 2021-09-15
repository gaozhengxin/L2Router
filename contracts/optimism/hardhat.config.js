require("@nomiclabs/hardhat-waffle");
require('@eth-optimism/hardhat-ovm');

const fs = require('fs');
const Web3 = require('web3');

var key = JSON.parse(fs.readFileSync("./key.json") + "");
var pwd = fs.readFileSync("./pwd") + "";
pwd = pwd.trim();

var myveryimportantprivatekey = new Web3().eth.accounts.decrypt(key, pwd).privateKey;


// This is a sample Hardhat task. To learn how to create your own go to
// https://hardhat.org/guides/create-task.html
task("accounts", "Prints the list of accounts", async () => {
  const accounts = await ethers.getSigners();

  for (const account of accounts) {
    console.log(account.address);
  }
});

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
  solidity: "0.7.6",
  ovm: {
    solcVersion: "0.7.6+commit.3b061308"
  },
  networks: {
    // Add this network to your config!
    optimistic: {
       url: 'http://127.0.0.1:8545',
       accounts: { mnemonic: 'test test test test test test test test test test test junk' },
       gasPrice: 15000000,      
       ovm: true // This sets the network as using the ovm and ensure contract will be compiled against that.
    },
    "opkovan": {
      url: 'https://kovan.optimism.io',
      // ********* Replace with your own mnemonic
      accounts: { mnemonic: 'test test test test test test test test test test test junk' },
      gasPrice: 15000000,
      ovm: true // This sets the network as using the ovm and ensure contract will be compiled against that.
   }    
  }
};

