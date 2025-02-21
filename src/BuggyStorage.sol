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
    // Bug 1: Array bounds
    function getNumber(uint index) public view returns (uint) { 
        require(index < numbers.length, "Index out of bounds");
        return numbers[index]; 
    }

    function addNumber(uint number) public {
        // Task 4: Implement adding numbers to the array 
        number.push(number);
       
    }

    // Bug 2: Slice array correctly
    function sliceArray(uint start, uint end) public view returns (uint[] memory) {
        require(start < end, "Start index must be less than end index");
        require(end <= numbers.length, "End index is out of bounds");
        uint[] memory _sliceArray = new uint[](end - start);
        for(uint256 i = start; i < end; i++){
            _sliceArray[i - start] = numbers[i];
        }
        return numbers[start:end];
    }

    // Bug 3: Concatenate strings correctly
    function setMessage(string memory newMessage) public {
        message =  string(abi.encodePacked(message, newMessage));
    }

    // Bug 4: How do we update numbers with memory as params?
    function validMemoryUsage(uint[] memory input) public {
        uint[] storage ref = numbers;
        // Implement logics to update numbers here
        for(uint i = 0; i < input.length; i++)
        ref.push(input[i]);
    }

    function getBalance(address user) public view returns (uint) {
        // Task 5: Returning the balance for a specific user
        return balances[user];
    }

    // Bug 5: How to safely pop elements from the array?
    function removeLastNumber() public {
        require(numbers.length > 0, "Array is empty")
        numbers.pop();
    }

    function updateBalance(address user, uint amount) public {
        // Task 6: Update balance of a user with a specific amount
        balance [user] = amount;
    }
}
