// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/*
Functions

1. Default with no keyword - requires gas
2. view - no gas
3. pure - no gas
*/
contract ViewAndPureFunctions {
    uint256 x;

    // Default with no keyword
    function someFunction() public {
        x = 34;
    }

    /*
    view
    1. only reads from the state
    2. does NOT require gas to execute
    */
    function getX() public view returns (uint256) {
        return x;
    }

    /*
    pure
    1. does NOT read or write to a state
    2. does NOT require gas
    */
    function add(uint _x, uint _y) public pure returns (uint256){
        return _x+_y;        
    }
}
