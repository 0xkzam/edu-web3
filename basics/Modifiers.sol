// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/*
Modifiers - pieces of code that can be run before or after any other function call


1. restrict access to functions (eg. only for a specific address)
2. validating the input of certain parameters
3. prevent certain types of attacks

*/
contract Modifiers {
    address owner;
    uint x;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Unathorized");
        _; // means run the rest of the code 
    }

    modifier checkValidity(){
        require(x > 0, "Invalid");        
        _;
    }

    function someFunction1() public onlyOwner {
        //run code        
    }

    function someFunction2() public onlyOwner {
        //run code
    }

    function someFunction3() public onlyOwner {
        //run code
    }
}
