// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract This {

    uint256 public data;

    function getData() public returns (uint256) {
        data = 45;

        return this.data(); // This is external access
    }

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

  
}

contract Test{

    function test() public returns (uint256){
        uint256 x = new This().getData();
        console.log("ssss %s", x);
        return x;

    }
}
