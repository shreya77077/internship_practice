// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract MyToken is IERC20 {
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public tokenSupply;

    mapping(address => mapping(address => uint256)) private allow;
    mapping(address => uint256) private balance;

    constructor()  {
        name = "smartSense";
        symbol = "SMART";
        decimals = 18;
        tokenSupply = 10000000000;
    }

    function totalSupply() external view override returns (uint256) {
        return tokenSupply;
    }

    function allowance(address owner, address spender) external view override returns (uint256) {
        return allow[owner][spender];
    }

    function approve(address spender, uint256 amount) external override returns (bool) {
        allow[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) external override returns (bool) {
        require(allow[sender][msg.sender] >= amount, "Not enough allowance");

        balance[sender] -= amount;
        balance[recipient] += amount;
        allow[sender][msg.sender] -= amount;

        emit Transfer(sender, recipient, amount);
        return true;
    }

    function transfer(address to, uint256 amount) external override returns (bool) {
        require(amount < balance[msg.sender]);
        balance[msg.sender] -= amount;
        balance[to] += amount;

        emit Transfer(msg.sender, to, amount);
        return true;
    }

    function balanceOf(address account) external view override returns (uint256) {
        return balance[account];
    }

    function mint(address account, uint256 amount) public {
        balance[account] += amount;
        tokenSupply += amount;
    }

    function burn(address account, uint256 amount) public {
        balance[account] -= amount;
        tokenSupply -= amount;
    }
}
