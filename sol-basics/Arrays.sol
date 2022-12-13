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

        arr2.push(23).push(34).push(45).push(56);
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
}
