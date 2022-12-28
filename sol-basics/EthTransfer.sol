// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "hardhat/console.sol";

/*
* https://docs.soliditylang.org/en/latest/types.html#address
* https://fravoll.github.io/solidity-patterns/secure_ether_transfer.html
*/

contract EthSender {
    /*
    Send some ETH to a given address (CA or EOA)

    Note the 'payable' keyword (both the address & the function)

    address payable: an address you can send Ether to

    Methods
    1. send - fixed gas
    2. transfer - fixed gas
    3. call,delegatecall,staticcall - gas adjustable & lower level functions

    Important global variables
    1. msg.data (bytes calldata): complete calldata
    2. msg.sender (address): sender of the message (current call)
    3. msg.sig (bytes4): first four bytes of the calldata (i.e. function identifier)
    4. msg.value (uint): number of wei sent with the message
    */
    function sendTo(address payable _to) public payable {
        uint256 amount = msg.value;

        console.log("From account balance: %s", msg.sender.balance);
        console.log("To account balance: %s", _to.balance);
        console.log("Transfer %s from %s to %s", amount, msg.sender, _to);

        //can omit the data variable since it's not used
        (bool success, bytes memory data) = _to.call{value: amount}("");
        require(success, "Transfer unsuccessful");
    }
}


/*
* This is used when contract needs to receive ETH 
*/
contract EthReceiver {
    /* 
    receive ETH iff msg.data is empty
    external - only accessible outside of the contract, consumes less gas than using 'public'
    */
    receive() external payable {}

    /*
    fallback is called when msg.data is NOT empty
    */
    fallback() external payable {}

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
