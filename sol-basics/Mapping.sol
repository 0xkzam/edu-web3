// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/*
* mapping ~ HashMaps, Dictionary, ...
*
* Mapping can ONLY be declared in Storage
* Important: Mappings cannot be iterated, use the following workarounds
*   1. Trick 1 - use a counter
*   2. Trick 2 - Use an array of keys
*/
contract Mapping {
    
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) nestedMap; //Nested mapping

    // Don't do this :P
    address constant ADDR1 = 0x71C7656EC7ab88b098defB751B7401B5f6d8976F;
    address constant ADDR2 = 0xc0ffee254729296a45a3885639AC7E10F9d54979;

    constructor() {
        _balances[ADDR1] = 10000;
        _balances[ADDR2] = 45600;
    }

    function getBalance(address _address) public view returns (uint256) {
        return _balances[_address];
    }

    function setBalance(uint256 _wei) public {
        _balances[msg.sender] = _wei;
    }

    function remove(address _address) public {
        delete _balances[_address];
    }

    /*
    * only internal or private functions can pass mappings as parametes
    */
    function test(mapping(address => uint256) storage map) internal {
        //TODO
    }
}
