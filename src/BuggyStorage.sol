// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

contract BuggyStorage {
    // DO NOT EDIT COMMENTS
    // Task 1: Declare an array as numbers;
    uint256[] public numbers = [10,20,30,40,50];
    // Task 2: Declare a string as message;
    string public message;
    // Task 3: Declare a mapping of address to balance as balances;
    mapping(address =>uint256) public balances;

    // Bug 1: Array bounds
    function getNumber(uint256 index) public view returns (uint256) {
        return numbers[index]; 
    }

    function addNumber(uint256 number) public {
        // Task 4: Implement adding numbers to the array
        numbers.push(number);
    }

    // Bug 2: Slice array correctly
    function sliceArray(uint256 start, uint256 end) public view returns (uint256[] memory) {
        uint256[] memory _numberSlice = new uint256[](end-start);

        for(uint256 i = start;i < end;i++) {
            _numberSlice[i-start] = numbers[i];
        }

        return _numberSlice;
    }

    // Bug 3: Concatenate strings correctly
    function setMessage(string calldata newMessage) public {
        message = string.concat(message, ' ', newMessage);
    }

    // Bug 4: How do we update numbers with memory as params?
    function validMemoryUsage(uint256[] memory input) public {
        require(input.length > 0, "Array length must be more than 0");
        // uint256[] storage ref = input;
        // Implement logics to update numbers here
        delete numbers;

        for(uint256 i = 0; i < input.length; i++) {
            numbers.push(input[i]);
        }
    }

    function getBalance(address user) public view returns (uint) {
        // Task 5: Returning the balance for a specific user
        return balances[user];
    }

    // Bug 5: How to safely pop elements from the array?
    function removeLastNumber() public {
        require(numbers.length>0, "Array length must be more than 0");
        numbers.pop();
    }

    function updateBalance(address user, uint amount) public {
        // Task 6: Update balance of a user with a specific amount
        balances[user] += amount;
    }
}
