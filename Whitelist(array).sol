//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;


contract Bank{

   mapping (address => uint64) public balances;
   
   address[] public accountAddress;

  
    event deposit( address accountAddress, uint64 balance);
    event witdraw(address accountAddress,uint64 remainingBal);
    event Transfer(address to,uint64 amount,uint64 balance );
    
    error InsufficientBalance(uint64 available, uint64 required);


   

    function Deposit(uint64 depositAmount, address index) public {
     bool Whitelisted = false;
     for (uint256 i = 0; i < accountAddress.length; i++) {
        if (accountAddress[i] == index) {
            Whitelisted = true;
            break;
          }
        }
     require(Whitelisted, "Rejected: Address not whitelisted");

     balances[msg.sender] += depositAmount;
     emit deposit(msg.sender, depositAmount);
    }

    function withdraw(uint64 withdrawAmount) public {
     if (withdrawAmount <= balances[msg.sender]) {
        balances[msg.sender] -= withdrawAmount;
        }
     emit witdraw(msg.sender,withdrawAmount);
    }

    function transfer(address to, uint64 amount) public {
     if (amount > balances[msg.sender])
        revert InsufficientBalance({
            available: balances[msg.sender],
            required: amount
        });
     balances[msg.sender] -= amount;
     balances[to] += amount;
     emit Transfer(msg.sender, amount, balances[msg.sender]);
    }

   
    function balance() public view returns (uint64) {
        return balances[msg.sender];
    }

    

}