// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuggyStorage {
    // DO NOT EDIT COMMENTS
    // Task 1: Declare an array as numbers;
    uint256[] numbers = [1,2,3,4,5];
    // Task 2: Declare a string as message;
    string message = "Mandala";
    // Task 3: Declare a mapping of address to balance as balances;
    mapping (address => uint256) public balances;

    // Bug 1: Array bounds
    function getNumber(uint index) public view returns (uint) {
        require(index < numbers.length, "Array Length are not that much");
        return numbers[index]; 
    }

    function addNumber(uint number) public {
        // Task 4: Implement adding numbers to the array
        numbers.push(number);
    }

    // Bug 2: Slice array correctly
    function sliceArray(uint start, uint end) public view returns (uint[] memory) {
        require(end > start, "End must be larger than start");
        require(end <= numbers.length, "End must be at least smaller or same with the array length");

        uint256[] memory _result = new uint[] (end - start);

        for(uint256 i = start; i < end; i++){
            _result[i - start] = numbers[i];
        }

        return _result;
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
        // Task 5: Returning the balance for a specific user
        return balances[user];
    }

    // Bug 5: How to safely pop elements from the array?
    function removeLastNumber(uint n) public {
        require(n <= numbers.length || n > 0,"Your input is much bigger than the array size");

        numbers[n] = numbers[numbers.length - 1];

        numbers.pop();
    }

    function updateBalance(address user, uint amount) public {
        // Task 6: Update balance of a user with a specific amount
        balances[user] = amount;
    }
}
