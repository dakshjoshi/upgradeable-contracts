pragma solidity 0.6.12;

import "./Storage.sol";

/*
* @dev This contract is accessed by Proxy contract 
* and can be updated if the owner wishes so
* This contract contains the logic of a function
*/

contract Function is Storage{

function getTheNumber(string memory _variable) public view returns(uint256){
return getNumber(_variable);
}

function setTheNumber(string memory _variable, uint256 toSet) public {
 setNumber(_variable, toSet);
}

}