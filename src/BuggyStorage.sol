// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuggyStorage {
    // DO NOT EDIT COMMENTS
    // Task 1: Declare an array as numbers;
       uint256[] public numbers;
    // Task 2: Declare a string as message;
        string public message;
    // Task 3: Declare a mapping of address to balance as balances;
        mapping (address => uint256) public balances;


    // Bug 1: Array bounds
    function getNumber(uint256 index) public view returns (uint256) {
        require(index < numbers.length, "End index out of bonds");
        return numbers[index]; 
    }

    function addNumber(uint256 number) public {
    // Task 4 : Implement adding numbers to the array 
        numbers.push(number);
    }

    // Bug 2: Slice array correctly
    function sliceArray(uint256 start, uint256 end) public view returns (uint256[] memory) {
        require(start < end, "start index must be less than end index");
        require(end <= numbers.length, "End index out of bounds");

        uint256[] memory result = new uint256[] (end - start);
        uint256 j = 0;
        for (uint256 i = start; i < end; i++) {
            result[j++] = numbers[i];
        }
        return result;
    }

    // Bug 3: Concatenate strings correctly
    function setMessage(string memory newMessage) public {
        message = string(abi.encodePacked(message, newMessage));
        message += newMessage;
    }

    // Bug 4: How do we update numbers with memory as params?
    function validMemoryUsage(uint256[] memory input) public {
        uint[] storage ref = input;
        // Implement logics to update numbers here
    }

    function getBalance(address user) public view returns (uint) {
        // Task 5: Returning the balance for a specific user
    }

    // Bug 5: How to safely pop elements from the array?
    function removeLastNumber() public {
        numbers.pop();
    }

    function updateBalance(address user, uint amount) public {
        // Task 6: Update balance of a user with a specific amount
    }
}
