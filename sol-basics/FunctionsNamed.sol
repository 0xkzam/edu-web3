// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

contract NamedFucntion {

    uint x;
    string y;

    function test() public{
        setValues({_x: 33, _y: "test"});
    }

    function setValues(uint _x, string memory _y) public{
        x = _x;
        y = _y;
    }


}