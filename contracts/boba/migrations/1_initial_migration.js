const AnyswapV5ERC20 = artifacts.require("AnyswapV5ERC20");
const SushiswapV2Proxy = artifacts.require("SushiswapV2Proxy");
const TransferHelper = artifacts.require("TransferHelper");
const SafeMathSushiswap = artifacts.require("SafeMathSushiswap");
const AnyswapV3Router = artifacts.require("AnyswapV3Router");

module.exports = function (deployer) {
  // anyETH
  //deployer.deploy(AnyswapV5ERC20, "anyETH", "anyETH", 18, "0x4200000000000000000000000000000000000006", true, {gas: 22300000});

  // anyUSDC
  //deployer.deploy(AnyswapV5ERC20, "anyUSDC", "anyUSDC", 18, "0xa9f6da3A7ed89804B0C1B46eA118b2bcd77A2823", true, {gas: 22330000});

  // sushi swap proxy
  //deployer.deploy(SushiswapV2Proxy, "0x0000000000000000000000000000000000000000", {gas: 20000000});

  // transfer helper library
  //deployer.deploy(TransferHelper, {gas: 20000000});
  TransferHelper.address = "0xECf2ADafF1De8A512f6e8bfe67a2C836EDb25Da3";

  // transfer safe math
  //deployer.deploy(SafeMathSushiswap, {gas: 20000000});
  SafeMathSushiswap.address = "0x94977c9888F3D2FAfae290d33fAB4a5a598AD764";

  // router
  deployer.link(TransferHelper, [AnyswapV3Router]);
  deployer.link(SafeMathSushiswap, [AnyswapV3Router]);
  //deployer.deploy(AnyswapV3Router, {gas: 40120000}); // MPC, SushiProxy
};
