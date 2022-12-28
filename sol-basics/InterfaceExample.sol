// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.7.6;

import "hardhat/console.sol";

/*
1. Can inherit from other interfaces
2. Must use external keyword in function declarations
3. NO state variables, NO modifiers, NO constructor
4. Functions declared are by default 'virtual'
*/
interface MiniDEX {
    enum Status {
        PENDING,
        COMPLETE,
        REJECTED
    }
    struct SwapInfo {
        uint256 chainId;
        string token;
        Status status;
    }

    function swap(
        address addressA,
        address addressB,
        uint256 amount
    ) external;
}

/*
* Implementation
*/
contract DEX {
    function swap(
        address addressA,
        address addressB,
        uint256 amount
    ) external view{
        console.log("DEX Impl: Transferred %s", amount);
    }
}

contract Test{

    function test() public{
        address d = address(new DEX());
        test(d);
    }

    function test(address _dexContractAddr) public {
        MiniDEX(_dexContractAddr).swap(address(0),address(0), 50000);
    }
}
