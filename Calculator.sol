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

           
        //    results.push(c); // Store the result in the array
          
    }

    // function mult(address payable _to, uint _amount) public view returns(uint256 ){
    //      //require(b > 0, "Error: b must be greater than 0");
    //      (bool success, ) = _to.call{value: _amount}("");
    //     require(success, "Failed to send Ether");
    //       uint256 e = a * b;

    //       return e; 
          
    // }
     function transfermultiply() payable external onlyOwner returns(uint8 e) {
         require(msg.value >= minAmount, "No min ether provided");
        payable(address(this)).transfer(msg.value); //here it is inbuit transfer key word
        emit Transfer(1 ether,address(this).balance);
        e = a * b;
        return e;
    }
    


    
    function sub() external{
         require(b > 0, "Error: b must be greater than 0");
          uint8 d = a - b;
          results.push(d); 
          
    }

    function div() external onlyOwner {
         require(b < 0, "Error: b must be greater than 0");
          uint8 f  = a / b;
          
         results.push(f); 
        
          
    }

    function mod() external  onlyOwner {
        uint8 g = a % b;
         results.push(g); 
    }

    function transferpower(address payable _to,uint _amount) external onlyOwner {
        _to.transfer(_amount); //here it is inbuit transfer key word
        emit Transfer(_amount,address(this).balance);
        uint8 h= a ** b;

           results.push(h); 
    }

//     function generateRandomNumber() public view returns (uint) {
//     uint timestamp = block.timestamp;
//     bytes32 hash = keccak256(abi.encodePacked(timestamp));
//     return hash.uint();
//    }
//    function someFunction() public {
//     uint randomNumber = generateRandomNumber();
//    }
    function generateRandomNumber() public view returns (bytes32) {
    uint256 timestamp = block.timestamp;
    bytes32 hash = keccak256(abi.encodePacked(timestamp));
    return hash;
   }

    // function someFunction() view public {
    // bytes32 randomNumber = generateRandomNumber();
    // // You can use the randomNumber as a bytes32 value
    // }
     
      function getResults() external view returns (uint8[] memory) {
        return results; // Return the array of results
    }
   



    
  }