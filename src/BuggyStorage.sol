// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuggyStorage {
    // DO NOT EDIT COMMENTS
    // Task 1: Declare an array as numbers;
    // done
    uint256[] internal numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];

    // Task 2: Declare a string as message;
    // done
    string internal message;

    // Task 3: Declare a mapping of address to balance as balances;
    // done
    mapping(address => uint) internal balances;

    // Bug 1: Array bounds
    // bugfix
    function getNumber(uint256 index) public view returns (uint256) {
        require(index < numbers.length, "index out of bounds");
        return numbers[index];
    }

    function addNumber(uint256 number) public {
        // Task 4: Implement adding numbers to the array
        // done
        numbers.push(number);
    }

    // Bug 2: Slice array correctly
    // bugfix
    function sliceArray(
        uint256 start,
        uint256 end
    ) public view returns (uint256[] memory) {
        require(start < end && end <= numbers.length, "Invalid slice range");
        uint total = end - start;
        uint[] memory sliceData = new uint256[](total);
        for (uint256 index = start; index < end; index++) {
            sliceData[index] = numbers[start + index];
        }

        return sliceData;
    }

    // Bug 3: Concatenate strings correctly
    // bugfix
    function setMessage(string memory newMessage) public {
        message = string.concat(message, newMessage);
    }

    // Bug 4: How do we update numbers with memory as params?
    // bugfix
    function validMemoryUsage(uint256[] memory input) public {
        delete numbers;
        // Implement logics to update numbers here
        for (uint i = 0; i < input.length; i++) {
            numbers.push(input[i]);
        }
    }

    function getBalance(address user) public view returns (uint) {
        // Task 5: Returning the balance for a specific user
        // done
        return balances[user];
    }

    // Bug 5: How to safely pop elements from the array?
    // bugfix
    function removeLastNumber() public {
        require(numbers.length > 0, "no elements to remove");
        numbers.pop();
    }

    function updateBalance(address user, uint amount) public {
        // Task 6: Update balance of a user with a specific amount
        // done
        balances[user] = amount;
    }
}
