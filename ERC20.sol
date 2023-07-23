// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function allowance(address account, address spender) external view returns (uint256);
    function approve(address owner ,address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

   contract MyToken is IERC20 {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;

    address public Owner;

    mapping(address => mapping(address => uint256)) private allow;
    mapping(address => uint256) private balance;


    modifier onlyOwner (){
        require(Owner == msg.sender,"not owner");
        _;
    } 
   

    constructor() {
        name = "smartSense";
        symbol = "SMART";  
        decimals = 18;
        totalSupply = 10000000000;
        Owner = msg.sender;
    }

 

    
    function allowance(address owner, address spender) external view override returns (uint256) {
        return allow[owner][spender];
    }
    


    function approve(address account , address spender, uint256 amount) external override returns (bool) {
        allow[account][spender] = amount; 
        emit Approval(account, spender, amount);
        return true;
    }
    
    function transferFrom(address sender, address recipient, uint256 amount) external override returns(bool){
       require(allow[sender][msg.sender] >= amount, "Not enough allowance ");
       balance[sender] -= amount;
       balance[recipient] += amount;
       allow[sender][msg.sender] -= amount;
       emit Transfer(sender, recipient, amount);
       return true;
    }

    
    function transfer(address to, uint256 amount) external override returns(bool){
        require(amount < balance[msg.sender]);
        balance[msg.sender] -= amount;
        balance[to] += amount;
        emit Transfer(msg.sender,to, amount);
        return true;
    }

    function balanceOf(address account) external view override returns(uint256){
        return balance[account];
    }

    function mint(address account , uint256 amount) public onlyOwner {
        balance[account] += amount;
        totalSupply += amount;
    }
    
    // }
//only owner/selfburn

//32798 gas

//32129
     function burn( uint256 amount) public {
       //require(account == msg.sender,"not the right account");
        balance[msg.sender] -= amount;
        totalSupply -= amount;
    }
  
    
   

}

