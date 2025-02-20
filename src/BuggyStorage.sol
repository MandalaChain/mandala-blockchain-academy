// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuggyStorage {
    // DO NOT EDIT COMMENTS
    // Task 1: Declare an array as numbers;
    uint256[] public myNumArray;

    // Task 2: Declare a string as message;
    string public myMessage;

    // Task 3: Declare a mapping of address to balance as balances;
    mapping(address => uint256) public myBalances;
    

    // Bug 1: Array bounds
    function getNumber(uint256 index) public view returns (uint256) {
        require(index < myNumArray.length, "Index out of bounds");
        return myNumArray[index]; 
    }

    function addNumber(uint256 number) public {
        // Task 4: Implement adding numbers to the array
        myNumArray.push(number);
    }

    // Bug 2: Slice array correctly
    function sliceArray(uint256 start, uint256 end) public view returns (uint256[] memory) {
        require(start < end, "start must be less than end index");
        require(end <= myNumArray.length, "end index out of bounds");

        uint256[] memory _slicedArray = new uint256[](end - start);

        for (uint256 i = start; i < end; i++) {
            _slicedArray[i - start] = myNumArray[i];
        }

        return _slicedArray;
    }

    // Bug 3: Concatenate strings correctly
    function setMessage(string memory newMessage) public {
        myMessage = string(abi.encodePacked(myMessage, newMessage));
    }

    // Bug 4: How do we update numbers with memory as params?
    function validMemoryUsage(uint256[] memory input) public pure returns (uint256[] memory){
        // Implement logics to update numbers heres
        for(uint256 i = 0; i < input.length; i++){
            input[i] = input[i] + 1;
        }

        return input;
    }

    function getBalance(address user) public view returns (uint) {
        // Task 5: Returning the balance for a specific user
        return myBalances[user];
    }

    // Bug 5: How to safely pop elements from the array?
    function removeLastNumber() public {
        require(myNumArray.length > 0, "Array is empty");
        myNumArray.pop();
    }

    function updateBalance(address user, uint256 amount) public {
        // Task 6: Update balance of a user with a specific amount
        myBalances[user] += amount;
    }
}
