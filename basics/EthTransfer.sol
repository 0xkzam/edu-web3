// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract EthSender {
    /*
    Send some ETH to _to address
    Note the 'payable' keyword
    */
    function sendTo(address payable _to) public payable {
       
        uint256 amount = msg.value;

        //can omit the data variable since it's not used
        (bool success, bytes memory data) = _to.call{value: amount}("");
        require(success, "Transfer unsuccessful");
    }
}

contract EthReceiver{
    // receive ETH iff msg.data is empty
    receive() external payable{}

    // fallback is called when msg.data is NOT empty
    fallback() external payable{}

    function getBalance() public view returns (uint){
        return address(this).balance;
    }

}