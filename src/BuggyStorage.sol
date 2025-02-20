// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuggyStorage {
    // DO NOT EDIT COMMENTS
    // Task 1: Declare an array as numbers;
    uint[] public numbers;
    
    // Task 2: Declare a string as message;
    string public message;
    
    // Task 3: Declare a mapping of address to balance as balances;
    mapping(address => uint) public balances;

    // Bug 1: Array bounds - Fixed by adding bounds check
    function getNumber(uint index) public view returns (uint) {
        require(index < numbers.length, "Index out of bounds");
        return numbers[index]; 
    }

    function addNumber(uint number) public {
        // Task 4: Implement adding numbers to the array
        numbers.push(number);
    }

    // Bug 2: Slice array correctly - Fixed by implementing proper array slicing
    function sliceArray(uint start, uint end) public view returns (uint[] memory) {
        require(start <= end, "Start must be <= end");
        require(end <= numbers.length, "End out of bounds");
        
        uint[] memory result = new uint[](end - start);
        for (uint i = 0; i < end - start; i++) {
            result[i] = numbers[start + i];
        }
        return result;
    }

    // Bug 3: Concatenate strings correctly - Fixed by using abi.encodePacked
    function setMessage(string memory newMessage) public {
        message = string(abi.encodePacked(message, newMessage));
    }

    // Bug 4: How do we update numbers with memory as params? - Fixed by copying array elements
    function validMemoryUsage(uint[] memory input) public {
        // Cannot assign memory to storage directly
        // Instead, we'll clear the array and copy elements
        delete numbers;
        for (uint i = 0; i < input.length; i++) {
            numbers.push(input[i]);
        }
    }

    function getBalance(address user) public view returns (uint) {
        // Task 5: Returning the balance for a specific user
        return balances[user];
    }

    // Bug 5: How to safely pop elements from the array? - Fixed by checking array length
    function removeLastNumber() public {
        require(numbers.length > 0, "Array is empty");
        numbers.pop();
    }

    function updateBalance(address user, uint amount) public {
        // Task 6: Update balance of a user with a specific amount
        balances[user] = amount;
    }
}