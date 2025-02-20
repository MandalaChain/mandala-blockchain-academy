// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuggyStorage {
    // DO NOT EDIT COMMENTS
    // Task 1: Declare an array as numbers;
    // Task 2: Declare a string as message;
    // Task 3: Declare a mapping of address to balance as balances;
    uint[] numbers;
    string message;
    mapping(address => uint) public balance;

    // Bug 1: Array bounds
    function getNumber(uint index) public view returns (uint) {
        require(index < numbers.length, "Index out of bounds!");
        return numbers[index];
    }

    function addNumber(uint number) public {
        // Task 4: Implement adding numbers to the array
        numbers.push(number);
    }

    // Bug 2: Slice array correctly
    function sliceArray(
        uint start,
        uint end
    ) public view returns (uint[] memory) {
        require(end >= start && end <= numbers.length, "Invalid slice bounds!");
        uint[] memory _sliced = new uint[](end - start);
        for (uint i = start; i < end; i++) {
            _sliced[i - start] = numbers[i];
        }

        return _sliced;
    }

    // Bug 3: Concatenate strings correctly
    function setMessage(string memory newMessage) public {
        message = string(abi.encodePacked(message, newMessage));
    }

    // Bug 4: How do we update numbers with memory as params?
    function validMemoryUsage(uint[] memory input) public {
        // uint[] storage ref = input;
        // Implement logics to update numbers here
        delete numbers;
        for (uint i = 0; i < input.length; i++) {
            numbers.push(input[i]);
        }
    }

    function getBalance(address user) public view returns (uint) {
        // Task 5: Returning the balance for a specific user
        return balance[user];
    }

    // Bug 5: How to safely pop elements from the array?
    function removeLastNumber() public {
        require(numbers.length > 0, "Empty array!");
        numbers.pop();
    }

    function updateBalance(address user, uint amount) public {
        // Task 6: Update balance of a user with a specific amount
        balance[user] = amount;
    }
}
