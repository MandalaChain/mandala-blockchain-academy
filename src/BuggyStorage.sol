// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuggyStorage {
    // DO NOT EDIT COMMENTS
    // Task 1: Declare an array as numbers;
    uint[] numbers;
    // Task 2: Declare a string as message;
    string message;
    // Task 3: Declare a mapping of address to balance as balances;
    mapping(address => uint) balances;

    error InvalidRangeNumers(uint start, uint end);
    error OutofBounds(uint end, uint length);

    // Bug 1: Array bounds
    function getNumber(uint index) public view returns (uint) {
        return numbers[index]; 
    }

    function addNumber(uint number) public {
        // Task 4: Implement adding numbers to the array
        numbers.push(number);
    }

    // Bug 2: Slice array correctly
    function sliceArray(uint start, uint end) public view returns (uint[] memory) {
        if (end < start){
            revert InvalidRangeNumers(start, end);
        }

        if (end > numbers.length) {
            revert OutofBounds(end, numbers.length);
        }

        // create a new array with the desired length
        uint[] memory result = new uint[](end - start);
        for (uint i = start; i < end; i++) {
            result[i - start] = numbers[i];
        }
        return result;
    }

    // Bug 3: Concatenate strings correctly
    function setMessage(string memory newMessage) public {
        message = string.concat(message, newMessage);
    }

    // Bug 4: How do we update numbers with memory as params?
    function validMemoryUsage(uint[] memory input) public {
        if (input.length > numbers.length) {
            revert OutofBounds(input.length, numbers.length);
        }

        // Implement logics to update numbers here
        for (uint i = 0; i < input.length; i++) {
            numbers[i] = input[i];
        }
    }

    function getBalance(address user) public view returns (uint) {
        // Task 5: Returning the balance for a specific user
        return balances[user];
    }

    // Bug 5: How to safely pop elements from the array?
    function removeLastNumber() public {
        numbers.pop();
    }

    function updateBalance(address user, uint amount) public {
        // Task 6: Update balance of a user with a specific amount
        balances[user] += amount;
    }
}
