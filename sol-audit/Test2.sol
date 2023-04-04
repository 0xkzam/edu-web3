// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.12;

import "@openzeppelin/contracts/access/Ownable.sol";


/*
* The function execute() is used to process payments. What could go wrong?
*
*/
contract Challenge is Ownable{

    function execute(address _to, uint256 _value, bytes calldata _data) external onlyOwner returns (bool, bytes memory){
        (bool success, bytes memory result) = _to.call{value: _value}(_data);
        return (success, result);
    }

}