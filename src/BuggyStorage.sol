// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuggyStorage {
    // DO NOT EDIT COMMENTS
    // Task 1: Declare an array as numbers;
    // Task 2: Declare a string as message;
    // Task 3: Declare a mapping of address to balance as balances;

    uint[] numbers;
    string message;
    mapping(address => uint) public balances;

    // Bug 1: Array bounds
    function getNumber(uint index) public view returns (uint) {
        if (numbers.length < index) {
            revert(
                "You can't retrieve the number because the array length is smaller than the input index, or you can push a number to this array"
            );
        }
        return numbers[index];
    }

    function addNumber(uint number) public {
        if (numbers.length > type(uint).max) {
            revert("The array is full");
        }
        // Task 4: Implement adding numbers to the array
        numbers.push(number);
    }

    // Bug 2: Slice array correctly
    function sliceArray(
        uint start,
        uint end
    ) public view returns (uint[] memory) {
        if (start > numbers.length) {
            revert("Start index out of bounds");
        }
        if (end < start) {
            revert("Start is greater than end");
        }

        if (end > numbers.length) {
            revert("End index is out of bounds");
        }

        uint[] memory slicedArray = new uint[](end - start);
        
        for (uint i = start; i < end; i++) {
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
        if (numbers.length != input.length) {
            revert(
                "numbers array and the input array not have same length"
            );
        }
        // uint[] memory storage ref = input;
        // Implement logics to update numbers here
        for (uint256 index = 0; index < input.length; index++) {
            numbers[index]=input[index];
        }
    }

    function getBalance(address user) public view returns (uint) {
        // Task 5: Returning the balance for a specific user
        return balances[user];
    }

    // Bug 5: How to safely pop elements from the array?
    function removeLastNumber() public {
        require(numbers.length > 0, "Array is empty");  
        numbers.pop();
    }

    function updateBalance(address user, uint amount) public {
        // Task 6: Update balance of a user with a specific amount
        balances[user] = amount;  
    }
}
