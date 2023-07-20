//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

interface IERC20{
   
    function totalSupply() external view returns(uint256);
    function balanceOf(address account)external view returns(uint256);
       //return balances[msg.sender];
    

    function transfer(address to,uint256 amount)external returns (bool);

    function allowance(address owner,address spender)external view returns (uint256);
    function approve(address spender,uint256 amount) external returns(bool);
    function transferFrom(address sender,address to,uint256 amount)external returns(bool);

     event Transfer(address indexed from , address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender,uint256 value);

    
}

contract MyToken is IERC20{
    
     mapping(address => uint64) public balance;
     //mapping(address => mapping(uint => Todo)) public User;
     mapping (address=>mapping(uint=>uint64)) public allowance;

     uint256 public tokenSupply;
    
    // constructor(){
        // string Name: smartSense;
        // string Symbol: sS;
        // uint256 Token_id: 219301280;
        string smartSense;
        string  sS;
        //uint256 219301280;

    // }

    function totalSupply() external view returns(uint256){
        //require(tokenSupply < amount);
        return tokenSupply;
    }

    function transfer(address to,uint256 amount) external returns(bool) {
        require(amount< balance[msg.sender]);
        balance[msg.sender] -= amount;
        balance[to] += amount;
        emit Transfer(msg.sender,to, amount);
        return true;
        }
    function  approve(address spender , uint256 amount) external returns(bool){
        allowance[msg.sender][spender]= amount;
        emit Approval(msg.sender,spender,amount);
    }

    function transferFrom(address sender, address to, uint256 amount) external returns(bool){
        allowance[msg.sender][sender] -= amount;
        balance[msg.sender[sender]] -= amount;
        balance[msg.sender][to] += amount;
        emit Transfer(sender, to, amount);
    }

    function balanceOf (address account)external view returns(uint256){
        return balance[msg.sender];
    }

    function mint(address account, uint256 amount) public{
      balance[msg.sender] += amount;
      tokenSupply += amount;
    }

    function burn(address account, uint256 amount) public{
       balance[msg.sender] -= amount;
       tokenSupply -= amount; 
    }

    //function
    
}