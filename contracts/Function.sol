pragma solidity 0.6.12;

import "./Storage.sol";

/*
* @dev This contract is accessed by Proxy contract 
* and can be updated if the owner wishes so
* This contract contains the logic of a function
*/

contract Function is Storage{

modifier onlyOwner () {
    require(msg.sender == owner, 'You are not the owner');
    _;
}

constructor () public {
    require(!_initialized);
    _initialized = true;
    initialize(msg.sender);
}

function initialize(address _owner) public {
owner = _owner;
}

function getTheNumber(address proxyAddress, string memory _variable) public view returns(uint256){
return getNumber(_variable);
}

function setTheNumber(address proxyAddress, string memory _variable, uint256 toSet) public onlyOwner{
 setNumber(_variable, toSet);
}

}