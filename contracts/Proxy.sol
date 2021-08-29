pragma solidity 0.6.12;

import "./Storage.sol";

/*
* @dev this contract is the main contract 
* with which the user will interact
* it calls the Function contract which can be updated 
* by simply updating the new function contract address 
*/

contract Proxy is Storage{

constructor() public {
    owner = msg.sender;
    //updContract = functionContract;
}

function addProxy(address newAddress) public {
    functionalAddress[newAddress] = true;
}

function removeProxy(address oldAddress) public {
    functionalAddress[oldAddress] = false;
}

function read() public view returns (uint256) {
return uintStorage["number"];
}

fallback() external payable {

//Setting variable for the data of the function 
//This is all the input values of the function
     bytes memory data = msg.data;

//Setting the proxy contract address
//My addition : 
bytes20 _address;

assembly {
        calldatacopy(0x0, 16, 36)
        _address := mload(0x0)
}

address proxy = address(_address);

//For security setting the condition that address is a one which we recognize
require(functionalAddress[proxy], "This is not an active proxy contract");

//The fun begins
assembly {
let result := delegatecall(gas(), proxy, add(data, 0x20), mload(data), 0, 0)
let size := returndatasize()
let ptr := mload(0x40)
returndatacopy(ptr, 0, size)

switch result
case 0 {revert(ptr, size)}
default {return (ptr, size)}
}
}

}