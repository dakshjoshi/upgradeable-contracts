pragma solidity 0.8.7;

import "./Storage.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

/*
* @dev this contract is the main contract 
* with which the user will interact
* it calls the Function contract which can be updated 
* by simply updating the new function contract address 
*/

contract Proxy is Storage, Pausable{

modifier onlyOwner()  {
require(hasRole(DEFAULT_ADMIN_ROLE, _msgSender()), "You are not the owner");
_;
}

modifier ifAdmin() {
   if(hasRole(DEFAULT_ADMIN_ROLE, _msgSender())){
       _;
   }else {
       _fallback();
   }
}

modifier ifUserOrUpgradeOfficer () {
    if(!hasRole(DEFAULT_ADMIN_ROLE, _msgSender())) {
        _;
    } else if(hasRole(UPGRADE_OFFICER, _msgSender())) {
        _;
    }
    else {
        revert();
    }
}

constructor() public {
    owner = msg.sender;
    //updContract = functionContract;
    
    //When role variables are decided we will remove the above 
    //owner = msg.sender update the code accordingly
    _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
    _setupRole(MANAGER_ROLE, _msgSender());
    _setupRole(UPGRADE_OFFICER, _msgSender());
    _setupRole(EMERGENCY_OFFICERS, _msgSender());
    _setupRole(PARTNERS, _msgSender());

}

function addProxy(address newAddress) public ifAdmin{
    functionalAddress[newAddress] = true;
}

function removeProxy(address oldAddress) public ifAdmin{
    functionalAddress[oldAddress] = false;
}

/** 
* @dev User calls a function --> is directly directed to fallback
* Admin calls a function --> is directed to the function
* If upgrade officer calls a function --> is directly directed to fallback
* rest of the admins are prohibited from using the fallback
*/

function _fallback() internal ifUserOrUpgradeOfficer {

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
require(functionalAddress[proxy] || proxy == updateStrage && hasRole(UPGRADE_OFFICER, _msgSender()));

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


fallback() external payable {
    _fallback();
}

}