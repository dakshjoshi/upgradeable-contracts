const Function = artifacts.require("Function");
const Proxy = artifacts.require('Proxy');

module.exports = async function (deployer, network, accounts) {
const funk = await Function.new()
const proxy = await Proxy.new()

// const pf = await Function.at(proxy.address)
// await pf.setTheNumber('number', 10)

// num = await pf.gettheNumber();
// console.log("After change: " + num.toNumber());

};
