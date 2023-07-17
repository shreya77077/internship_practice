//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import "@openzeppelin/contracts/access/Ownable.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";
//import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/cryptography/Keccak256.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";



contract calculator{
    uint8 public a = 5;
    uint8 public b = 10;
    //require (b > 0, "Error");
    uint minAmount = 1 ether;

    uint8[] public results; // Array to store the results

    address payable public owner;

    event Transfer(uint amount,uint balance );

    constructor() {
        owner = payable(msg.sender); //payable??
    }

    modifier onlyOwner(){
        require(msg.sender == owner,"Not owner");
        _;
    }

    using SafeMath for uint8;

  function store(uint8 _a) public virtual{
             a = _a;
         } 

         function store2 (uint8 _b) public virtual{
             b = _b;
         } 


    function add() external view returns(uint8){
         require(b > 0, "Error: b must be greater than 0");
          return a + b;

           
        
          
    }

   
     function transfermultiply() payable external onlyOwner returns(uint8 ) {
         require(msg.value >= minAmount, "No min ether provided");
        payable(address(this)).transfer(msg.value); //here it is inbuit transfer key word
        emit Transfer(1 ether,address(this).balance);
        //e = a * b;
        return  a * b ;
    }
    


    
    function sub() external view returns(uint8){
         require(b > 0, "Error: b must be greater than 0");
           
          return a - b;
          
    }

    function div() external onlyOwner view returns(uint8) {
         require(b < 0, "Error: b must be greater than 0");
          
         return a / b;
        
          
    }

    function mod() external  onlyOwner {
        uint8 g = a % b;
         results.push(g); 
    }

    function transferpower(address payable _to,uint _amount) external onlyOwner  returns(uint8) {
        _to.transfer(_amount); //here it is inbuit transfer key word
        emit Transfer(_amount,address(this).balance);
       
           return a ** b;
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