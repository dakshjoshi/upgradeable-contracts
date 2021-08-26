pragma solidity 0.6.12;

import "./Storage.sol";

/*
* @dev this contract is the main contract 
* with which the user will interact
* it calls the Function contract which can be updated 
* by simply updating the new function contract address 
*/

contract Proxy is Storage{

address public updContract;

// constructor(address functionContract) {
//      updContract = functionContract;
// }

function updateContract(address newAddress) public {
    updContract = newAddress;
}

function read() public view returns (uint256) {
return uintStorage["number"];
}

 fallback() external payable {
     //Setting the proxy contract address
     address implementaton = updContract;

     //For security setting the condition that address !=0
     //Because that will lead us no where
     require(updContract != address(0));

     //Setting variable for the data of the function 
     //This is all the input values of the function
     bytes memory data = msg.data;

//The fun begins
assembly {
let result := delegatecall(gas(), implementaton, add(data, 0x20), mload(data), 0, 0)
let size := returndatasize()
let ptr := mload(0x40)
returndatacopy(ptr, 0, size)

switch result
case 0 {revert(ptr, size)}
default {return (ptr, size)}
}
}
}