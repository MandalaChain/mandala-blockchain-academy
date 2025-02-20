// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuggyStorage {
    // DO NOT EDIT COMMENTS
    // Task 1: Declare an array as numbers;
    // Task 2: Declare a string as message;
    // Task 3: Declare a mapping of address to balance as balances;
    uint256[] public numbers;
    string public message;
    mapping(address => uint256) public balance;

    // Bug 1: Array bounds
    function getNumber(uint256 index) public view returns (uint256) {
        require(index < numbers.length);
        return numbers[index]; 
    }

    function addNumber(uint256 number) public {
        // Task 4: Implement adding numbers to the array
        numbers.push(number);
    }

    // Bug 2: Slice array correctly
    function sliceArray(uint256 start, uint256 end) public view returns (uint256[] memory) {
        require(start <= end, "start index cannot be greater than end index");
        require(end <= numbers.length, "end index cannot be greater than array length");
        uint256[] memory _sliceArray = new uint256[](end-start);
        for (uint256 i = start; i<end; i++) 
        {
            _sliceArray[i - start] = _sliceArray[i];
        }

        return _sliceArray;
    }

    // Bug 3: Concatenate strings correctly
    function setMessage(string memory newMessage) public view{
        string(abi.encodePacked(message, newMessage));
    }

    
    // Bug 4: How do we update numbers with memory as params?
    function validMemoryUsage(uint256[] memory input) public {
        // Implement logics to update numbers here
        for (uint256 i = 0; i<input.length;i++){
            numbers.push(input[i]);
        }
    }

    function getBalance(address user) public view returns (uint256) {
        // Task 5: Returning the balance for a specific user
        return balance[user];
    }

    // Bug 5: How to safely pop elements from the array?
    function removeLastNumber() public {
        require(numbers.length!=0, "array numbers is empty");
        numbers.pop();
    }

    function updateBalance(address user, uint256 amount) public {
        // Task 6: Update balance of a user with a specific amount
        balance[user] = amount;
    }
}
