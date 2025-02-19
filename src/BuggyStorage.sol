// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuggyStorage {
    // DO NOT EDIT COMMENTS
    // Task 1: Declare an array as numbers;
    uint256[] private numbers;
    // Task 2: Declare a string as message;
    string private message;
    // Task 3: Declare a mapping of address to balance as balances;
    mapping(address => uint256) private balances;

    // Bug 1: Array bounds
    function getNumber(uint256 index) public view returns (uint256) {
        require(index < numbers.length, "Index out of bounds");
        return numbers[index]; 
    }

    function addNumber(uint256 number) public {
        // Task 4: Implement adding numbers to the array
        numbers.push(number);
    }

    // Bug 2: Slice array correctly
    function sliceArray(uint256 start, uint256 end) public view returns (uint256[] memory) {
        require(start < end && end <= numbers.length, "Invalid range");

        uint256 length = end - start;
        uint256[] memory result = new uint256[](length);

        unchecked {
            for(uint256 i=0; i < length; i++) {
                result[i] = numbers[start + i];
            }
        }
        return result;
    }
    
    // Bug 3: Concatenate strings correctly
    function setMessage(string calldata newMessage) public {
        message = string.concat(message, newMessage);
    }

    // Bug 4: How do we update numbers with memory as params?
    function validMemoryUsage(uint256[] calldata input) public {
        require(input.length > 0, "Empty input");
        delete numbers;
        // Implement logics to update numbers here
        unchecked {
            for(uint256 i = 0; i < input.length; i++) {
                numbers.push(input[i]);
            }
        }
    }

    function getBalance(address user) public view returns (uint256) {
        // Task 5: Returning the balance for a specific user
        return balances[user];
    }

    // Bug 5: How to safely pop elements from the array?
    function removeLastNumber() public {
        if(numbers.length == 0) revert("No numbers in the array");
        numbers.pop();
    }

    function updateBalance(address user, uint256 amount) public {
        // Task 6: Update balance of a user with a specific amount
        balances[user] = amount;
    }
}