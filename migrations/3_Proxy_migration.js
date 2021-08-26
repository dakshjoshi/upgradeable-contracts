const Proxy = artifacts.require("Proxy");
const Function = artifacts.require("Function");

module.exports = async function (deployer) {
  //let functionContract = await Function.deployed();
  deployer.deploy(Proxy);
};
