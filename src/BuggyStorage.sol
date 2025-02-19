// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuggyStorage {
    // DO NOT EDIT COMMENTS
    // Task 1: Declare an array as numbers;
    // Task 2: Declare a string as message;
    // Task 3: Declare a mapping of address to balance as balances;
    uint256[] public numbers;
    string public message;
    mapping(address => uint256) public balance;

    // Bug 1: Array bounds
    function getNumber(uint index) public view returns (uint) {
        require (index < numbers.length, "array index out of bounds");
        return numbers[index]; 
    }

    function addNumber(uint number) public {
        numbers.push(number);
        // Task 4: Implement adding numbers to the array
    }

    // Bug 2: Slice array correctly
    function sliceArray(uint start, uint end) public view returns (uint[] memory) {
        require(start < end, "less than end index");
        require(end <= numbers.length, "less than");
        uint[] memory slicedArray = new uint[](end - start);
        for(uint256 i = start; i< end; i++){
            slicedArray[i - start] = numbers[i];
        }
        return slicedArray;
    }

    // Bug 3: Concatenate strings correctly
    function setMessage(string memory newMessage) public {
        message = string(abi.encodePacked(message, newMessage));
    }

    // Bug 4: How do we update numbers with memory as params?
    function validMemoryUsage(uint[] memory input) public {
        for (uint256 i = 0; i < input.length; i++) {
            numbers.push(input[i]);
        // Implement logics to update numbers here
    }
    }
    function getBalance(address user) public view returns (uint) {
        return balance[user];
        // Task 5: Returning the balance for a specific user
    }

    // Bug 5: How to safely pop elements from the array?
    function removeLastNumber() public {
        require(numbers.length > 0, "doesnt displayed");
        numbers.pop();
    }

    function updateBalance(address user, uint amount) public {
        balance[user] = amount;
        // Task 6: Update balance of a user with a specific amount
    }
}
