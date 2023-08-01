//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "./TokenBank.sol";

contract TokenBankk {
   
    MyToken public token;
    mapping(address => uint256) public balance;
    mapping(address => address) public nominees;
    mapping(address => uint256) public deadline;

    constructor(address tokenAddress) {  
        token = MyToken(tokenAddress);      
   }

   function deposit(uint256 amount, uint256 deadlineInSeconds)public {
       require(token.transferFrom(msg.sender,address(this),amount), "Transfer failed");

       deadline[msg.sender] = block.timestamp + deadlineInSeconds;
       balance[msg.sender] += amount;
   }

   function assignNominee(address nominee) public {
     nominees[msg.sender] = nominee;
   }
   
   function changeNominee(address newNominee)public{
       nominees[msg.sender] = newNominee;
   }

    // this is transferfrom, create one transfer too
   function withdraw(uint256 amount, address depositor) public {
       require(isNominee(msg.sender,depositor), "Caller is not a nominee");// need not check this condition when depositor= msg.sender.
       require(balance[depositor] >= amount, "Not enough balance");
       require(token.transfer(depositor, amount), "Transfer failed");

       balance[depositor] -= amount;
   }



   function isNominee(address nominee, address depositor) public view returns(bool){
       return nominees[depositor] == nominee;
   }
}
