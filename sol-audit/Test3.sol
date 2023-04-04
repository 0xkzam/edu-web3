// SPDX-License-Identifier: BUSL-1.1

pragma solidity 0.8.9;

import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import {SafeERC20} from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol"; 
import {ERC20PresetMinterPauserUpgradeable} from "@openzeppelin/contracts-upgradeable/token/ERC20/presets/ERC20PresetMinterPauserUpgradeable.sol"; 
import {Initializable} from "@openzeppelin/contracts/proxy/utils/Initializable.sol"; 

contract Chalenge is Initializable, ERC20PresetMinterPauserUpgradeable {
    using SafeERC20 for IERC20; 
    struct Withdrawal { address usr; uint amount; }
    IERC20 public immutable reserveToken; 
    Withdrawal[] public withdrawals; 
    uint public start; 

    constructor(address _reserveToken) {
         require(_reserveToken != address(0), "Challenge: null _reserveToken"); 
         reserveToken = IERC20(_reserveToken);
    }

    function init() external { 
        super.initialize("cUSD", "cUSD"); 
    }

    function withdraw(uint amount) external { 
        burn(amount); 
        withdrawals.push(Withdrawal(msg.sender, amount));
    }

    function processWithdrawals() external {
        uint reserve = reserveToken.balance0f(address(this)); 
        require( reserve >= withdrawals[start].amount, "Cannot process withdrawals at this time: Not enough balance"); 
        uint i = start; 
        while (i < withdrawals.length && (i - start)) {
            Withdrawal memory withdrawal = withdrawals[i]; 
            if (reserve < withdrawal.amount) { 
                break;
            }
            reserveToken.safeTransfer(withdrawal.usr, withdrawal.amount); 
            reserve -= withdrawal.amount; 
            i += 1;
        } 
        start = i; 
    }

    function  _disableInitializers() override(Initializable) internal {

    }

    function _getInitializedVersion() override internal   view returns (uint8) {
        return 0;
    }

    modifier initializer() override {
       _;
    }
}
