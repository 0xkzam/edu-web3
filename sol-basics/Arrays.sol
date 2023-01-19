// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "hardhat/console.sol";

/*
 * Arrays CANNOT hold multiple data structures
 * 3 types: fixed size arrays, dynamic arrays & dynamic memory arrays
 * Be mindfull of the location of the array data is stored ie. Storage & Memory
 * @see https://docs.soliditylang.org/en/latest/types.html
 *
 * Note: Neever allow an array in Solidity to grow too large, since in theory iterating over a large array could end
 * up costing more in gas fees than the value of the transaction is worth.
 */
contract Arrays {


    //Don't have to specify data location (storage/memory) when declared as a state variable
    uint256[5] arr1; //Fixed size   
    uint256[] arr2; //Dynamic arrays, data stored in Storage
    uint256[] arrMemory1 = new uint256[](5); //Dynamic memory arrays (new keyword), data stored in Memory
    bytes[] arrMemory2 = new bytes[](5);

    //nesting level counts from right to left
    uint256[][5] arrL1FixedL2Dynamic; // a fixed size(5) array of dynamic arrays
    uint256[2][] arrL1DynamicL2Fixed; // a dynamic array of fixed size(2) arrays
    uint256[2][5] arrL1FixedL2Fixed; // 5 arrays of fixed size(2) arrays
    uint256[][] arrL1DynamicL2Dynamic; // a dynamic array of dynamic arrays

   

    function test(uint256[] memory _memoryArr) public {

        arr2 = _memoryArr; // Copies the whole array to arr2 (from Memory to Storage)

        arr2.push(23);
        uint256[] storage arr4 = arr2; // Storage to Storage ie. just a pointer

        uint256[] memory arr5 = arr2;
    }

    /*
    * 1. Only fixed length arrays are allowed when initializing within functions
    * 2. You can have storage array pointing to another storage(state) array
    * 3. Functions can return arrays!!! but always the location must be memory
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
