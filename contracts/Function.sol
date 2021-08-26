pragma solidity 0.8.7;

import "./Storage.sol";

/*
* @dev This contract is accessed by Proxy contract 
* and can be updated if the owner wishes so
* This contract contains the logic of a function
*/

contract Function is Storage{

function getTheNumber() public view returns(uint256){
    return getNumber();
}

function setTheNumber(uint256 toSet) public {
    setNumber(toSet);
}

}