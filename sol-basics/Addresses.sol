// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.12;

/*
 * Note the use of 'this' keyword. It refers to the current contract ie. address data type
 * Note: All contracts can be converted to address type
 */
contract Addresses {
    function getContractAddress() public view returns (address) {
        return address(this);
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    // get the signature of function `getContractBalance()`
    function getFunctionSelector() public pure returns (bytes4) {
        return this.getContractBalance.selector;
    }

    function externalFunction() external pure returns (string memory) {
        return "External function";
    }

    function some() internal pure returns (uint256){
        return 9;

    }

    //Calling an external function within the same contract using 'this'
    function test() public view returns (string memory, string memory) {
        return ("test() calling external function:", this.externalFunction());
    }
    
}
