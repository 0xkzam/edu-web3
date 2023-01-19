// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "hardhat/console.sol";
import "./Strings.sol";


contract Calculations{

    /*
    * Pre EIP-1559 (London upgrade)
    * eg: Gas fees = 30,000 x 300 Gwei = 0.009 ETH
    */
    function getGasFees(uint256 gasUnits, uint256 gasUnitPrice) public pure returns (uint256){
        return gasUnits * gasUnitPrice;    
    }

    /*
    * Post EIP-1559 (London upgrade)
    * eg: Gas fees = 21000 * (10Gwei + 1Gwei) = 0.000231 ETH
    * Burnt fee = Base Fee Per Gas x Gas Used 
    */
    function getGasFees(uint256 gasUnits, uint256 baseFeePerGas, uint256 maxPriorityFeePerGas) public pure returns (uint256){
        return gasUnits * (baseFeePerGas + maxPriorityFeePerGas);    
    }


    /********************************************************************************************
    * Dummy method
    * from: 0x142e881fac6c5756a49fe6ab4bb639e200000dee
    * to: 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48
    * tokenId: 14
    */
    function transferFrom(address from, address to, uint256 tokenId) public virtual  {
        //TODO
    }
    /*********************************************************************************************/
    /*
    *   transferFrom(address from, address to, uint256 tokenId) => transferFrom(address,address,uint256)
    */
    function getSelector(string memory _func) public pure returns (bytes4) {
        return bytes4(keccak256(bytes(_func)));
    }

    function getSelector() public pure returns (bytes4) {       
        return this.transferFrom.selector;
    }

    function getDataPayload() public pure returns (bytes memory payload){
        string memory functionSignature = "transferFrom(address,address,uint256)";
        address from = 0x142e881FAC6C5756A49fE6ab4bB639E200000DEE;
        address to = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
        uint256 tokenId = 14;
        
        payload = abi.encodeWithSignature(functionSignature, from, to, tokenId);        
    }

    
    function test() public view {

        //transferFrom(address,address,uint256)
        string memory selector = "0x23b872dd";
        console.log("selector: %s", selector);

        //address from = 0x142e881FAC6C5756A49fE6ab4bB639E200000DEE;
        string memory from = "142e881FAC6C5756A49fE6ab4bB639E200000DEE";
        from = Strings.pad32(from);
        console.log("from: %s", from);

        //address to = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
        string memory to= "A0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48";
        to = Strings.pad32(to);
        console.log("to: %s", to);

        //uint256 tokenId = 14;
        string memory tokenId = "E";
        tokenId = Strings.pad32(tokenId);
        console.log("tokenId: %s", tokenId);        

        console.log("payload: %s", string(abi.encodePacked(selector, from, to, tokenId)));
        
    }
}

