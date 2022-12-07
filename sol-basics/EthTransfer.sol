// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.10;

import "hardhat/console.sol";

contract EthSender {
    /*
    Send some ETH to _to address

    Note the 'payable' keyword (both the address & the function)
    address payable: an address you can send Ether to
    send,trasnfer,call,deligatecall,staticcall

    msg.data (bytes calldata): complete calldata
    msg.sender (address): sender of the message (current call)
    msg.sig (bytes4): first four bytes of the calldata (i.e. function identifier)
    msg.value (uint): number of wei sent with the message
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
This is used when contract needs to receive ETH 
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
