// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract TodoList {
    struct Todo {
        string things;
        bool completed;
        uint256 deadline;
    }

   
    Todo[] public todos;

     mapping(address => mapping(uint => Todo)) public User;

    function userstore(string calldata _things, uint _deadline, uint id) public {
        User[msg.sender][id] = Todo(_things,false,_deadline);
    }

    // function create(string calldata _things, uint256 _deadline) public {
    //     todos.push(Todo(_things, false, block.timestamp + _deadline));
    // }

    function updateThings(uint256 _index, string calldata _things) public {
        todos[_index].things = _things;
    }

    function toggleCompleted(uint256 _index) external {
        require(!todos[_index].completed, "Already completed");
        require(block.timestamp < todos[_index].deadline, "Deadline passed");
        todos[_index].completed = true;
    }

    function remove(uint256 _index) public returns (Todo[] memory) {
        require(_index < todos.length, "Invalid index");

        for (uint256 i = _index; i < todos.length - 1; i++) {
            todos[i] = todos[i + 1];
        }
        todos.pop();
        return todos;
    }
}
