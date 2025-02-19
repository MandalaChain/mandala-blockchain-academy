// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuggyStorage {
    // DO NOT EDIT COMMENTS
    // Task 1: Declare an array as numbers;
    uint256[] public numbers = [1,2,3,4,5,6,7,8];
    // Task 2: Declare a string as message;
    string message = "Mandala";
    // Task 3: Declare a mapping of address to balance as balances;
    mapping(address => uint256) public balances;

    // Bug 1: Array bounds
    function getNumber(uint index) public view returns (uint) {
        require(index < numbers.length, "index out of bounds");
        return numbers[index]; 
    }

    function addNumber(uint number) public {
        numbers.push(number);
        // Task 4: Implement adding numbers to the array
    }

    // Bug 2: Slice array correctly
    function sliceArray(uint start, uint end) public view returns (uint[] memory) {
        require(start <= end && end <= numbers.length, "Invalid");
        uint256[] memory _sliceArray = new  uint256[](end - start);
        for(uint i = start; i < end;i++){
            _sliceArray[i-start] = numbers[i];
        }
        return _sliceArray;
    }

    // Bug 3: Concatenate strings correctly
    function setMessage(string memory newMessage) public {
        newMessage = "Chain";
        message = string.concat(message,newMessage);
    }

    // Bug 4: How do we update numbers with memory as params?
    function validMemoryUsage(uint[] memory input) public {
        // uint[] storage ref = input;
        // Implement logics to update numbers here
        for(uint256 i = 0; i < input.length; i++){
            numbers.push(input[i]);
        }
    }

    function getBalance(address user) public view returns (uint) {
        return balances[user];
        // Task 5: Returning the balance for a specific user
    }

    // Bug 5: How to safely pop elements from the array?
    function removeLastNumber() public {
        require(numbers.length > 0, "array already empty");
        numbers.pop();
    }

    function updateBalance(address user, uint amount) public {
      balances[user] = amount;
        // Task 6: Update balance of a user with a specific amount
    }
}
