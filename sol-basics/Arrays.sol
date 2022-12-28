// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "hardhat/console.sol";

/*
 * Arrays CANNOT hold multiple data structures
 * 3 types: fixed size arrays, dynamic arrays & dynamic memory arrays
 * Be mindfull of the location of the array data is stored ie. Storage & Memory
 * @see https://docs.soliditylang.org/en/latest/types.html
 */
contract Arrays {
    uint256[5] arr1; //Fixed size

    //Don't have to specify data location (storage/memory) when declared as a state variable
    uint256[] arr2; //Dynamic arrays, data stored in Storage
    uint256[] arr3 = new uint256[](5); //Dynamic memory arrays, data stored in Memory

    uint256[][5] arrLevel1; //Level 1 nested array
    uint256[2][] arrLevel2; //Level 2 nested array

    function test(uint256[] memory _memoryArr) public {
        arr2 = _memoryArr; // Copies the whole array to arr2 (from Memory to Storage)

        arr2.push(23);
        uint256[] storage arr4 = arr2; // Storage to Storage ie. just a pointer

        uint256[] memory arr5 = arr2;
    }

    function testFixedArrays() public {
        arr1[0] = 23; //Fixed size array elements accessed by the index
        uint256 len = arr1.length;
        console.log("Length of arr1: ", len);
    }

    function testDynamicArrays() public {
        //arr2[0] = 44;
        arr2.push(20);
        arr2.push(30);
        //arr2.pop();
        console.log("Length of arr2: ", arr2.length);
    }

    /*
    * 1. Only fixed length arrays are allowed when initializing within functions
    * 2. You can have storage array pointing to another storage(state) array
    */
    function testLocalMultiDimArrays() public pure returns (string[][] memory){
            string[][] memory d2 = new string[][](3); // 3 Arrays and elements of those arrays are also arrays
            d2[0] = new string[](2); // Must be initialized
            d2[1] = new string[](4); // Must be initialized
            d2[2] = new string[](2); // Must be initialized

            d2[0][0] = "0-A";
            d2[0][1] = "0-B";

            d2[1][0] = "1-C";
            d2[1][1] = "1-D";
            d2[1][2] = "1-X";
            d2[1][3] = "1-Y";

            d2[2][0] = "2-P";
            d2[2][1] = "2-Q";

            return d2;
    }
}
