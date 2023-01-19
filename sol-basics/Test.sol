// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.12;

contract Test {
    uint256 public x;
    uint256 public y;
    uint256[] public values;


    function addValue(uint256 _x) public{
        values.push(_x);
    }
    function setXandY(uint256 _x, uint256 _y) public {
        x = _x;
        y = _y;
    }

    function setX(uint256 _x) public {
        x = _x;
    }

    function getX() public view returns (string memory result) {
        if (x > 0) {
            result = "x greater than 0";
        } else {
            result = "x <= 0";
        }
    }

    function test() public {
        for (uint256 i = 0; i < 10; i++) {
            x++;
        }
    }


}
