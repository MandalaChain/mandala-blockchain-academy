// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuggyStorage {
    // DO NOT EDIT COMMENTS
    // Task 1: Declare an array as numbers;
    uint[] private _numbers;
    // Task 2: Declare a string as message;
    string private _message;
    // Task 3: Declare a mapping of address to balance as balances;
    mapping(address => uint) private _balances;

    // Bug 1: Array bounds
    function getNumber(uint index) public view returns (uint) {
        require(index <= _numbers.length, "Index out of bounds");
        return _numbers[index];
    }

    function addNumber(uint number) public {
        // Task 4: Implement adding numbers to the array
        _numbers.push(number);
    }

    // Bug 2: Slice array correctly
    function sliceArray(
        uint start,
        uint end
    ) public view returns (uint[] memory) {
        require(start < end, "Invalid range");
        require(
            start >= _numbers.length || end >= _numbers.length,
            "Index out of bounds"
        );

        uint[] memory _result = new uint[](end - start);
        for (uint i = start; i < end; i++) {
            _result[i - start] = _numbers[i];
        }
        return _result;
    }

    // Bug 3: Concatenate strings correctly
    function setMessage(string memory newMessage) public {
        _message = string(abi.encodePacked(_message, newMessage));
    }

    // Bug 4: How do we update numbers with memory as params?
    function validMemoryUsage(uint[] memory input) public {
        // Implement logics to update numbers here
        delete _numbers;
        for (uint i = 0; i < input.length; i++) {
            _numbers.push(input[i]);
        }
    }

    function getBalance(address user) public view returns (uint) {
        // Task 5: Returning the balance for a specific user
        return _balances[user];
    }

    // Bug 5: How to safely pop elements from the array?
    function removeLastNumber() public {
        require(_numbers.length > 0, "Array is empty");
        _numbers.pop();
    }

    function updateBalance(address user, uint amount) public {
        // Task 6: Update balance of a user with a specific amount
        _balances[user] = amount;
    }
}
