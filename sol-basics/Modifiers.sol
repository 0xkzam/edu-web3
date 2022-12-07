// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

/*
Modifiers - pieces of code that can be run before or after any other function call

1. Restrict access to functions (eg. only for a specific address)
2. Validating the input of certain parameters
3. Prevent certain types of attacks

*/
contract Modifiers {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Unathorized");
        _; // means run the rest of the code 
    }

    modifier checkValidity(address _addr){

        //address(0) = zero address (0x0)
        require(_addr != address(0), "Invalid");        
        _;
    }

    function someFunction1() public onlyOwner {
        //run code        
    }

    // Using mulitiple modifiers
    function someFunction2(address _addr) public onlyOwner checkValidity(_addr) {
        //run code
    }    
}
