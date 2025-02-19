// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuggyStorage {
    // DO NOT EDIT COMMENTS
    // Task 1: Declare an array as numbers;
    // Task 2: Declare a string as message;
    // Task 3: Declare a mapping of address to balance as balances;

    uint[] private numbers;
    string private message;
    mapping(address => uint) private balances;

    // Bug 1: Array bounds
    function getNumber(uint index) public view returns (uint) {
        require(index < numbers.length, "Index out of bounds");
        return numbers[index];
    }

    function addNumber(uint number) public {
        numbers.push(number);
    }

    // Bug 2: Slice array correctly
    function sliceArray(uint start, uint end) public view returns (uint[] memory) {
        require(start <= end && end <= numbers.length, "Invalid slice range");
        uint[] memory slicedArray = new uint[](end - start);
        for (uint i = 0; i < end - start; i++) {
            slicedArray[i] = numbers[start + i];
        }
        return slicedArray;
    }

    // Bug 3: Concatenate strings correctly
    function setMessage(string memory newMessage) public {
        message = string(abi.encodePacked(message, newMessage));
    }

    // Bug 4: How do we update numbers with memory as params?
    function validMemoryUsage(uint[] memory input) public {
        for (uint i = 0; i < input.length; i++) {
            numbers.push(input[i]);
        }
    }

    function getBalance(address user) public view returns (uint) {
        return balances[user];
    }

    // Bug 5: How to safely pop elements from the array?
    function removeLastNumber() public {
        require(numbers.length > 0, "Array is empty");
        numbers.pop();
    }

    function updateBalance(address user, uint amount) public {
        balances[user] += amount;
    }
}
