// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuggyStorage {
    // DO NOT EDIT COMMENTS
    // Task 1: Declare an array as numbers;
    uint[] public _numbers;

    // Task 2: Declare a string as message;
     string public _message;

    // Task 3: Declare a mapping of address to balance as balances;
    mapping(address => uint) public _balances;

    // Bug 1: Array bounds
    function getNumber(uint index) external view returns (uint) {
        require(index < _numbers.length, "Index out of bounds");
        return _numbers[index];
    }

    function addNumber(uint number) public {
        // Task 4: Implement adding numbers to the array
        _numbers.push(number);
    }

    // Bug 2: Slice array correctly
    function sliceArray(uint start, uint end) external view returns (uint[] memory) {
        require(start < end && end <= _numbers.length, "Invalid slice range");
        uint[] memory slicedArray = new uint[](end - start);
        for (uint i = start; i < end; i++) {
            slicedArray[i - start] = _numbers[i];
            }
        return slicedArray;
    }

    // Bug 3: Concatenate strings correctly
    function setMessage(string calldata newMessage) external {
        _message = string(abi.encodePacked(_message, newMessage));
    }

    // Bug 4: How do we update numbers with memory as params?
    function validMemoryUsage(uint[] calldata input) external {
        // Implement logics to update numbers here
        for (uint i = 0; i < input.length; i++) {
            _numbers.push(input[i]); // Menambahkan setiap elemen dari input ke numbers
        }
    }

    function getBalance(address user) external view returns (uint) {
        // Task 5: Returning the balance for a specific user
        return _balances[user];
    }

    // Bug 5: How to safely pop elements from the array?
    function removeLastNumber() external {
        require(_numbers.length > 0, "No numbers to remove");
        _numbers.pop();
    }

    function updateBalance(address user, uint amount) external {
        // Task 6: Update balance of a user with a specific amount
        _balances[user] += amount; 
    }
}
