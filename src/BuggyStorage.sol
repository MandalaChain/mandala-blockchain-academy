// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuggyStorage {
    // DO NOT EDIT COMMENTS
    // Task 1: Declare an array as numbers;
    // Task 2: Declare a string as message;
    // Task 3: Declare a mapping of address to balance as balances;
    uint256[] numbers;
    string message = "mandala";
    mapping (address => uint256) balances;

    // Bug 1: Array bounds
    function getNumber(uint index) public view returns (uint) {
        require(index < numbers.length, "index overflow");
        return numbers[index]; 
    }

    function addNumber(uint number) public {
        // Task 4: Implement adding numbers to the array
        numbers.push(number);
    }

    // Bug 2: Slice array correctly
    function sliceArray(uint256 start, uint256 end) public view returns (uint256[] memory) {
        require(start < end && end <= numbers.length, "index overflow");
        uint256[] memory newNumbers = new uint256[](end - start);
        for (uint256 i = start; i < end; i++) 
        {
            newNumbers[i - start] = numbers[i];
        }
        return newNumbers;
    }

    // Bug 3: Concatenate strings correctly
    function setMessage(string calldata newMessage) public {
        message = string(abi.encodePacked(message, newMessage));
    }

    function getMessage() public view returns(string memory) {
        return message;
    }

    // Bug 4: How do we update numbers with memory as params?
    function validMemoryUsage(uint256[] memory input) public {
        // Implement logics to update numbers here
        numbers = input;
    }

    function getBalance(address user) public view returns (uint256) {
        // Task 5: Returning the balance for a specific user
        return balances[user];
    }

    // Bug 5: How to safely pop elements from the array?
    function removeLastNumber() public {
        require(numbers.length > 0, "No more element");
        numbers.pop();
    }

    function updateBalance(address user, uint256 amount) public {
        // Task 6: Update balance of a user with a specific amount
        balances[user] = amount;
    }
}
