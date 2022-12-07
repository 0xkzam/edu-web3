// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "hardhat/console.sol";

/*
 * 1. Logs on the Ethereum blockchain
 * 2. Cheaper comparing to explicit methods of logging
 */
contract Events {
    event TestEvent(address owner, string message);

    function test(string memory _msg) public {
        emit TestEvent(msg.sender, _msg);
        //more code
    }
}
