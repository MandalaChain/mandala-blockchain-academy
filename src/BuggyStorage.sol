// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuggyStorage {
    // DO NOT EDIT COMMENTS
    // Task 1: Declare an array as numbers;
    uint256[] public numbers;
    // Task 2: Declare a string as message;
    string public message;
    // Task 3: Declare a mapping of address to balance as balances;
    mapping(address => uint256) public balances;

    // Bug 1: Array bounds
    function getNumber(uint256 index) public view returns (uint256) {
        require(index<numbers.length,"index must be less than array length");
        return numbers[index]; 
    }

    function addNumber(uint256 number) public {
        require(number > 0,"number must be greater than 0");
        // Task 4: Implement adding numbers to the array
        numbers.push(number);

    }

    // Bug 2: Slice array correctly
    function sliceArray(uint256 start, uint256 end) public returns (uint256[] memory) {
        require(start<end,"start index must be less than end index");
        require(end<=numbers.length,"end index must be less than array length");

        uint256[] memory _sliceArray = new uint256[](end-start);
        for(uint256 i=start;i<end;i++)
        {
            _sliceArray[i-start] = numbers[i];
        }
        numbers = _sliceArray;
        return numbers;
    }

    // Bug 3: Concatenate strings correctly
    function setMessage(string memory newMessage) public {
        require(bytes(newMessage).length > 0,"new message must not be empty");
        message = string(abi.encodePacked(message,newMessage));
        // message += newMessage;
    }

    // Bug 4: How do we update numbers with memory as params?
    function validMemoryUsage(uint256[] memory input) public {
        // Implement logics to update numbers here
        require(input.length > 0,"input array must not be empty");
        for(uint256 i=0;i<input.length;i++) {
            numbers.push(input[i]);
        }
        // uint256[] storage ref = input;
    }

    function getBalance(address user) public view returns (uint256) {
        // Task 5: Returning the balance for a specific user
        require(user != address(0),"user address must not be 0");
        return balances[user];
    }

    // Bug 5: How to safely pop elements from the array?
    function removeLastNumber() public {
        require(numbers.length > 0,"array must not be empty");
        numbers.pop();
    }

    function updateBalance(address user, uint256 amount) public {
        // Task 6: Update balance of a user with a specific amount
        require(user != address(0),"user address must not be 0");
        require(amount > 0,"amount must be greater than 0");
        // Implement logics to update balance here
        balances[user] += amount;
        
    }
}
