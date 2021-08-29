pragma solidity 0.6.12;

/*
* @dev this contract is to set common 
* storage which will be inherited by both
* proxy and Function contract
*/

contract Storage {
    mapping (string => uint256) public uintStorage;

/*Instead of doing uint256 public number;
* we do the above mentined mapping 
* a mapping for "number"=> uint256 
* Benefit : tomorrow if we need to add more variables like cat, dog, crocodile
* Then we can just define those variables in the mapping
* Like cat=> uint256, dog=> uint256, crocodile=> uint256
* Like uintStorage["dog"] = 10;
*/

/*
* Now we will create many mappings for each variable type
*/

mapping (string => address) public addressStorage;
mapping (string => bool) public boolStorage;
mapping (string => string) public stringStorage;
mapping (string => bytes4) public bytesStorage;

mapping (address => bool) public functionalAddress;


address public owner;
bool public _initialized;

    function getNumber(string memory _variable) internal view returns(uint256) {
return uintStorage[_variable];
    }
    
    function setNumber(string memory _variable, uint256 _number) internal  {
    uintStorage[_variable] = _number;
    }
}