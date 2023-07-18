// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract TodoList {
    struct Todo {
        string things;
        bool completed;
        uint256 deadline;
    }

    mapping(address => mapping(uint => Todo)) public User;
    mapping(address => uint[]) private userTodoIds;

    function userstore(string calldata _things, uint256 _deadline, uint256 id) public {
        User[msg.sender][id] = Todo(_things, false, _deadline);
        userTodoIds[msg.sender].push(id);
    }

    function updateThings(address user, uint256 id, string calldata _things) public {
        User[user][id].things = _things;
    }

    function toggleCompleted(address user, uint256 id) public {
        require(!User[user][id].completed, "Already completed");
        require(block.timestamp < User[user][id].deadline, "Deadline passed");
        User[user][id].completed = true;
    }

    function remove(address user, uint256 id) public {
        require(User[user][id].deadline > 0, "Todo does not exist");

        delete User[user][id];
        uint[] storage todoIds = userTodoIds[user];
        for (uint256 i = 0; i < todoIds.length; i++) {
            if (todoIds[i] == id) {
                todoIds[i] = todoIds[todoIds.length - 1];
                todoIds.pop();
                break;
            }
        }
    }

    function getUserTodoIds(address user) public view returns (uint[] memory) {
        return userTodoIds[user];
    }
}
