// SPDX-License-Identifier: BUSL-1.1

pragma solidity =0.8.9;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract LinearVesting is Ownable {
    using SafeERC20 for IERC20;
    IERC20 public immutable token;
    uint256 public start;
    uint256 public end;
    mapping(address => Vester) public vest;

    struct Vester {
        uint192 amount;
        uint64 lastClaim;
        uint256 start;
    }

    modifier hasStarted() {
        require(
            start != 0,
            "Challenge::_hasStarted: Vesting hasn't started yet"
        );
        _;
    }

    // Token is initialized @ the constructor and is not a zero-address
    constructor() {
        token = new TestToken();
    }

    function getClaim() external view returns (uint256 vestedAmount) {
        Vester memory vester = vest[msg.sender];
        return _getClaim(vester.amount, vester.lastClaim);
    }

    /*
     * @dev Allows a user to claim their pending vesting amount of the vested claim
     * - the vesting period has started
     * - the caller must have a non-zero vested amount
     */
    function claimConverted() external returns (uint256 vestedAmount) {
        // Assume vester exists
        Vester memory vester = vest[msg.sender];
        require(
            vester.start < block.timestamp,
            "LinearVesting::claim: Not Started Yet"
        );

        vestedAmount = _getClaim();
        // Assume vestedAmount > 0
        require(vestedAmount != 0, "LinearVesting::claim: Nothing to claim");

        vester.amount -= uint192(vestedAmount);
        vester.lastClaim = uint64(block.timestamp);
        vest[msg.sender] = vester;

        token.safeTransfer(msg.sender, vestedAmount);
    }

    function begin() external onlyOwner {
        start = block.timestamp;
        end = block.timestamp + 1 * 365 days;
    }

    function _getClaim(uint192 _amount, uint64 _lastClaim)
        private
        view
        returns (uint256 vestedAmount)
    {
        return 0;
    }

    function _getClaim() private view returns (uint256 vestedAmount) {
        return 0;
    }
}


contract TestToken is IERC20{
    function totalSupply() external view returns (uint256){
        return 0;
    }

    
    function balanceOf(address account) external view returns (uint256){
        return 0;
    }

    
    function transfer(address to, uint256 amount) external returns (bool){
        return true;
    }

   
    function allowance(address owner, address spender) external view returns (uint256){
        return 0;
    }

   
    function approve(address spender, uint256 amount) external returns (bool){
        return true;
    }

   
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool){
        return true;
    }

}
