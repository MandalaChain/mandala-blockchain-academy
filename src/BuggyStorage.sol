// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuggyStorage {
    // DO NOT EDIT COMMENTS
    // Task 1: Declare an array as numbers;
    // Task 2: Declare a string as message;
    // Task 3: Declare a mapping of address to balance as balances;
    uint[] public numbers;
    string public message;
    mapping(address=> uint) public balances;

    // Bug 1: Array bounds
    function getNumber(uint index) public view returns (uint) {
        require(index <= numbers.length-1, "bounds");
        return numbers[index]; 
    }

    function addNumber(uint number) public {
        // Task 4: Implement adding numbers to the array
        numbers.push(number);
    }

    // Bug 2: Slice array correctly
    function sliceArray(uint start, uint end) public view returns (uint[] memory) {
        // return numbers[start:end];
        require(start < end, "Start index must be less than end");
        require(end <= numbers.length, "End index out of bounds");

        uint[] memory _sliceArray = new uint[](end - start);
        for (uint i = start; i < end; i++) {
            _sliceArray[i - start] = numbers[i];
        }

        return _sliceArray;
    }

    // Bug 3: Concatenate strings correctly
    function setMessage(string memory newMessage) public {
        // message += newMessage;
        message= string(abi.encodePacked(message, newMessage));
    }

    // Bug 4: How do we update numbers with memory as params?
    function validMemoryUsage(uint[] memory input) public {
        require(input.length > 0, "nothing changes");
        numbers= input;
    }

    function getBalance(address user) public view returns (uint) {
        // Task 5: Returning the balance for a specific user
        return balances[user];
    }

    // Bug 5: How to safely pop elements from the array?
    function removeLastNumber() public {
        require(numbers.length>0, "empty arrays");
        numbers.pop();
    }

    function updateBalance(address user, uint amount) public {
        // Task 6: Update balance of a user with a specific amount
        require(amount> 0,"nothing adding");
        balances[user]+= amount;
    }
}
