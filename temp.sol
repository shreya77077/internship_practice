// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Calculator {
    uint8 public a = 5;
    uint8 public b = 10;
    uint minAmount = 1 ether;

    uint8[] public results;

    address payable public owner;

    event Transfer(uint amount, uint balance);

    constructor() {
        owner = payable(msg.sender);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    using SafeMath for uint8;

    function store(uint8 _a) public {
        a = _a;
    }

    function store2(uint8 _b) public {
        b = _b;
    }

    function add() external view returns (uint8) {
        require(b > 0, "Error: b must be greater than 0");
        return a + b;
    }

    function transferMultiply() payable external onlyOwner returns (uint8 e) {
        require(msg.value >= minAmount, "No min ether provided");
        payable(address(this)).transfer(msg.value);
        emit Transfer(1 ether, address(this).balance);
        e = a * b;
        return e;
    }

    function sub() external {
        require(b > 0, "Error: b must be greater than 0");
        uint8 d = a - b;
        results.push(d);
    }

    function div() external onlyOwner {
        require(b < 0, "Error: b must be greater than 0");
        uint8 f = a / b;
        results.push(f);
    }

    function mod() external onlyOwner {
        uint8 g = a % b;
        results.push(g);
    }

    function transferPower(address payable _to, uint _amount) external onlyOwner {
        _to.transfer(_amount);
        emit Transfer(_amount, address(this).balance);
        uint8 h = a ** b;
        results.push(h);
    }

    function generateRandomNumber() public view returns (bytes32) {
        uint256 timestamp = block.timestamp;
        bytes32 hash = keccak256(abi.encodePacked(timestamp));
        return hash;
    }

    function getResults() external view returns (uint8[] memory) {
        return results;
    }
}
