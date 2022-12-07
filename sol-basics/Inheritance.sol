// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.8.12 <0.9.0;

/*
1. Supports multiple inheritance, but there is an order
2. Functions should be marked as 'virtual' to be able to be overridden in the child contract
3. Child contract must use 'override' keyword
*/
contract A {
    // Note the virtual keyword
    function test() public pure virtual returns (string memory) {
        return "contract A";
    }
}

contract B {
    function foo() public pure returns (string memory) {
        return "contract B";
    }
}

contract C is A {
    /* 
    1. Note the override & virtual keywords
    2. Should be marked with virtual if u want to override again
    */
    function test() public pure virtual override returns (string memory) {
        return "contract C";
    }
}

contract D is A, C {
    /*
    super - calls the immediate parent
    */
    function test() public pure override(C, A) returns (string memory) {
        return super.test();
    }
}

contract E is B, A {
    function bar() public pure returns (string memory) {
        return string.concat(test(), foo()); //solidity >= 8.12
    }
}
