// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

/*
 * https://docs.soliditylang.org/en/latest/control-structures.html#error-handling-assert-require-revert-and-exceptions
 */

contract Test {


    /*
    * Assert
    * 1. Must be used only to check for cases that should not happen eg: when testing
    * 2. This will consume all the gas sent with this transaction
    */
    function testAssert() public pure{
        
        uint256 someInt = 4;
        assert(someInt == 4);
    }

     /*
    * Require
    * 1. Used for validating conditions
    * 2. Will revert the state changes & refund remaining gas to the caller
    */
    function testRequire() public view {
        
        bool success = (address(this) == msg.sender);
        require(success, "This can happen");
    }

    /*
    * Revert
    * 1. Similar to require, usually used with if/else conditions (when the code is more complex)
    * 2. Revert the state changes & refund remaining gas to the caller
    */
    function testRevert() public pure {

        bool success = false;
        if (!success) {
            revert("This can happen");
        }
    }
}
