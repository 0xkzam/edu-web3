// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

library Strings {

    function convertToBytes() public pure {
      string memory _s = "test";
      bytes memory arr = bytes(_s); //cast the string to bytes to iterate

      for (uint256 i = 0; i < arr.length; i++) {
        if(arr[i] == 's'){
          //TODO
        }        
      }
    }


    /*
    * https://ethereum.stackexchange.com/questions/11247/keccak256parameter-how-to-pass-a-string-to-be-hashed
    */
    function bytes32ToString(bytes32 x) public pure returns (string memory) {
        bytes memory bytesString = new bytes(32);
        uint256 charCount = 0;
        for (uint256 j = 0; j < 32; j++) {
            bytes1 char = bytes1(bytes32(uint256(x) * 2**(8 * j)));
            if (char != 0) {
                bytesString[charCount] = char;
                charCount++;
            }
        }
        bytes memory bytesStringTrimmed = new bytes(charCount);
        for (uint256 j = 0; j < charCount; j++) {
            bytesStringTrimmed[j] = bytesString[j];
        }
        return string(bytesStringTrimmed);
    }

    function pad32(string memory _s) internal pure returns (string memory){
        uint zeros = 64 - bytes(_s).length;
        string memory z="";
        for(uint32 i = 0; i < zeros; i++){
            z = string(abi.encodePacked(z, "0"));
        }
        return string(abi.encodePacked(z, _s));
    }

    function toHex(bytes memory buffer) public pure returns (string memory) {

        // Fixed buffer size for hexadecimal convertion
        bytes memory converted = new bytes(buffer.length * 2);

        bytes memory _base = "0123456789abcdef";

        for (uint256 i = 0; i < buffer.length; i++) {
            converted[i * 2] = _base[uint8(buffer[i]) / _base.length];
            converted[i * 2 + 1] = _base[uint8(buffer[i]) % _base.length];
        }

        return string(abi.encodePacked(converted));
    }   
}
