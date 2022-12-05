// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/*
mapping ~ HashMaps, Dictionary, ...
*/
contract Mapping {
    mapping(address => uint256) private _balances;

    // Don't do this :P
    address constant addr1 = 0x71C7656EC7ab88b098defB751B7401B5f6d8976F;
    address constant addr2 = 0xc0ffee254729296a45a3885639AC7E10F9d54979;

    constructor() {
        _balances[addr1] = 10000;
        _balances[addr2] = 45600;
    }

    function getBalance(address _address) public view returns (uint256) {
        return _balances[_address];
    }

    function setBalance(uint256 _wei) public {
        _balances[msg.sender] = _wei;
        //Note the global variable
    }

    function remove(address _address) public {
        delete _balances[_address];
    }
}
