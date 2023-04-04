// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./CrowdFunding.sol";
import "hardhat/console.sol";

/*
* Remix Unittest plugin is crashing/buggy. So I created this TestSuite contract for testing
* set GAS=300M 
* set VALUE
* run Testsuite.test()
*
* @author Kz
*/
contract TestSuite {    

    function test() external payable {
        CrowdFunding v = new CrowdFunding();
        Test1 t1 = new Test1(v);         
        Test2 t2 = new Test2(v); 
        Test3 t3 = new Test3(v);
        Test4 t4 = new Test4(v);
        Test5 t5 = new Test5(v);

        t1.execute(); //Test creating new project and search
        t2.execute(); //Test creating new project and search

        t3.execute{value:1000}(); //Test participate to project
        t4.execute{value:1000}(); //Test participate to project
        t5.execute{value:1000}(); //Test participate to project
        
        t2.executeTestWithdraw(); //Test withdraw funds
        t1.executeTestWithdraw(); //Test withdraw funds
    }
}

contract Assert{

    function assertEqual(uint256 a, uint256 b, string memory message) internal pure{
        require(a == b, message);       
    }

    function assertEqual(address a, address b, string memory message) internal pure{
        require(a == b, message);       
    }

    function assertEqual(bool a, bool b, string memory message) internal pure{
        require(a == b, message);       
    }

    function assertEqual(string memory a, string memory b, string memory message) internal pure{      
        require(keccak256(bytes(a)) == keccak256(bytes(b)), message);        
    }

    function assertOk(bool a, string memory message)internal pure{
        require(a, message);      
    }
}

contract Test1 is Assert{ 
    CrowdFunding v;

    constructor(CrowdFunding _c){
        v = _c;
    }

    /*
    * Create and search the created 1st project
    */
    function execute() external payable{ 
        console.log("Test1=====");
        try v.createProject("", "blahbdafdas fdas f") {
           assertOk(false, "Test1: Empty title");
        }catch Error(string memory reason){
            assertOk(true, reason);
        }
        v.createProject("AA", "Testing 1111");

        uint256 projectID = 0;
        string memory title; string memory des; address owner; uint256 numPartipants; uint256 funding;
        (title, des, owner, numPartipants, funding) = v.searchForProject(projectID);

        assertEqual(title, "AA", "Test1:title");
        assertEqual(des, "Testing 1111", "Test1:description");
        assertEqual(owner, address(this), "Test1:owner");
    }

    /*
    * Call this test after other tests are executed
    * Total withdrawal should be 1500
    */
    function executeTestWithdraw() external payable{
        console.log("Test1.executeTestWithdraw=====");
        uint256 projectID = 0;
        address owner;
        (, , owner, , ) = v.searchForProject(projectID); 
        assertEqual(owner, address(this), "Test1.executeTestWithdraw::owner");   

        uint256 preBalance = address(this).balance;
        try v.withdrawFunds(projectID){
            uint256 withdrawal = address(this).balance - preBalance;
            assertEqual(withdrawal, 1500, "Test1.executeTestWithdraw: withdrawal = 1500");
        }catch{
            assertOk(false, "Test1.executeTestWithdraw: Must be project owner");
        }

        uint256 funding;
        (, , , , funding) = v.searchForProject(projectID);        
        assertEqual(funding, 0, "Test1.executeTestWithdraw:total funding amount");    
    }        

    receive() external payable {}
    fallback() external payable {}
}

contract Test2 is Assert{ 
    CrowdFunding v;

    constructor(CrowdFunding _c){
        v = _c;
    }

    /*
     * Create and search the created 2nd project
    */
    function execute() external payable{ 
        console.log("Test2=====");
        v.createProject("BB", "Testing 2222");

        uint256 projectID = 1;
        string memory title; string memory des; address owner; uint256 numPartipants; uint256 funding;
        (title, des, owner, numPartipants, funding) = v.searchForProject(projectID);
        
        assertEqual(title, "BB", "Test2:title");
        assertEqual(des, "Testing 2222", "Test2:description");
        assertEqual(owner, address(this), "Test2:owner");     
    }

    /*
    * Call this test after other tests are executed
    * This should fail to withdraw
    */
    function executeTestWithdraw() external payable{
        console.log("Test2.executeTestWithdraw=====");
        uint256 projectID=0;
        try v.withdrawFunds(projectID){
            assertOk(false, "Test6: Must be project owner");
        }catch Error(string memory reason){
            assertEqual(reason, "Must be project owner", "Test6: Must be project owner");
        }
    }

    receive() external payable {}
    fallback() external payable {}

}

contract Test3 is Assert{ 
    CrowdFunding v;

    constructor(CrowdFunding _c){
        v = _c;
    }

    /*
     * Participate in projectID = 0
     * 1. participateToProject 
     * 2. searchForProject
    */
    function execute() external payable{   
        console.log("Test3===");     
        //assertEqual(true, msg.value > 100, "test3:Not enough ether (Set value before calling test() )");

        uint256 projectID = 0;
        v.participateToProject{value: 1000}(projectID);

        uint256 numPartipants;
        uint256 funding;
        (, , , numPartipants, funding) = v.searchForProject(projectID);
        assertEqual(numPartipants, 1, "Test3:contribution 1:particpants");
        assertEqual(funding, 1000, "Test3:contribution 1:total funding");
    }
}


contract Test4 is Assert{ 
    CrowdFunding v;

    constructor(CrowdFunding _c){
        v = _c;
    }
    /*
     * Participate in projectID = 0
     * 1. participateToProject 
     * 2. searchForProject
     * 3. getContributers
     * 4. retrieveContributions 
    */
    function execute() external payable{
        console.log("Test4===");

        uint256 projectID = 0;
        v.participateToProject{value: 500}(projectID);

        uint256 numPartipants;
        uint256 funding;
        (, , , numPartipants, funding) = v.searchForProject(projectID);
        assertEqual(numPartipants, 2, "Test4:contribution 2:particpants");
        assertEqual(funding, 1500, "Test4:contribution 2:total funding=1500");

        assertEqual(v.getContributers(projectID).length, 2, "Test4:total number of participants");

        uint256 contributionOfParticipant = v.retrieveContributions(v.getContributers(projectID)[1], projectID);
        assertEqual(contributionOfParticipant, 500, "Test4:total contribution of the participant");
    }
}


contract Test5 is Assert{ 
    CrowdFunding v;

    constructor(CrowdFunding _c){
        v = _c;
    }
    /*
     * Participate in projectID=1
     * 1. participateToProject 
     * 2. searchForProject
     * 3. getContributers
     * 4. retrieveContributions 
    */
    function execute() external payable{
        console.log("Test5===");
        //assertEqual(true, msg.value > 2000, "test5:Not enough ether");

        uint256 projectID = 1;
        v.participateToProject{value: 500}(projectID);

        uint256 numPartipants;
        uint256 funding;
        (, , , numPartipants, funding) = v.searchForProject(projectID);
        assertEqual(numPartipants, 1, "Test5:contribution 2:particpants");
        assertEqual(funding, 500, "Test5:contribution 2:total funding");

        assertEqual(v.getContributers(projectID).length, 1, "Test5:total number of participants");

        uint256 contributionOfParticipant = v.retrieveContributions(v.getContributers(projectID)[0], projectID);
        assertEqual(contributionOfParticipant, 500, "Test5:total contribution of the participant");
    }
}