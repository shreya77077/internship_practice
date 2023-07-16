// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Bank {
    mapping(address => uint64) public balances;
    mapping(address => bool) public isWhitelisted;

    event deposit(address accountAddress, uint64 balance);
    event withdraw(address accountAddress, uint64 remainingBal);
    //event Transfer(address to, uint64 amount, uint64 balance);
    event Transfer(address indexed from, address indexed to, uint64 amount);
    error InsufficientBalance(uint64 available, uint64 required);

    function createAccount() public {
        isWhitelisted[msg.sender] = true;
    }

    function Deposit(uint64 depositAmount) public {
        require(isWhitelisted[msg.sender], "Rejected: Address not whitelisted");

        balances[msg.sender] += depositAmount;
        emit deposit(msg.sender, depositAmount);
    }

    // function Withdraw(uint64 withdrawAmount) public {
    //     if (withdrawAmount <= balances[msg.sender]) {
    //         balances[msg.sender] -= withdrawAmount;
    //     }
    //     emit withdraw(msg.sender, withdrawAmount);
    // }

     modifier sufficientBalance(uint64 amount){
        require (balances[msg.sender]>= amount, "Insufficient Balance in account");
        _;
    }

    function Withdraw(uint64 withdrawAmount) public sufficientBalance(withdrawAmount){
        balances[msg.sender] -= withdrawAmount;
        emit withdraw(msg.sender,withdrawAmount);
       
    } 


    function transfer(address to, uint64 amount) public {
        if (amount > balances[msg.sender])
            revert InsufficientBalance({
                available: balances[msg.sender],
                required: amount
            });
        balances[msg.sender] -= amount;
        balances[to] += amount;
        //emit Transfer(msg.sender, amount, balances[msg.sender]);
        emit Transfer(msg.sender, msg.sender,amount);
    }

    function balance() public view returns (uint64) {
        return balances[msg.sender];
    }
}
