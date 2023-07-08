
//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.0.0/contracts/token/ERC20/ERC20.sol";


contract MyToken is ERC20{
    constructor(string memory name, string memory symbol) ERC20(name,symbol) {
        // 1.00 USD = 100
        _mint(msg.sender,100*10**uint(decimals()));
    }
}
