// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuggyStorage {
    // DO NOT EDIT COMMENTS
    // Task 1: Declare an array as numbers;
    // Task 2: Declare a string as message;
    // Task 3: Declare a mapping of address to balance as balances;
    uint256[] public numbers;
    string public message;
    mapping(address => uint256) public balances;

    // Bug 1: Array bounds
    function getNumber(uint index) public view returns (uint) {
        require(index < numbers.length, "index out of bounds");
        return numbers[index];
    }

    function addNumber(uint number) public {
        // Task 4: Implement adding numbers to the array
        numbers.push(number);
    }

    // Bug 2: Slice array correctly
    function sliceArray(
        uint start,
        uint end
    ) public view returns (uint[] memory) {
        require(start < end, "start must be less than end");
        require(
            end <= numbers.length,
            "end must be less than or equal to numbers length"
        );
        uint256[] memory _sliced = new uint256[](end - start);

        unchecked {
            for (uint256 i = start; i < end; i++) {
                _sliced[i - start] = numbers[i];
            }
        }
        return _sliced;
    }

    // Bug 3: Concatenate strings correctly
    function setMessage(string memory newMessage) public view {
        // message += newMessage;
        string(abi.encodePacked(message, newMessage));
    }

    // Bug 4: How do we update numbers with memory as params?
    function validMemoryUsage(uint[] memory input) public {
        uint[] memory ref = input;
        // Implement logics to update numbers here
        for (uint i = 0; i < ref.length; i++) {
            numbers.push(ref[i]);
        }
    }

    function getBalance(address user) public view returns (uint) {
        // Task 5: Returning the balance for a specific user
        return balances[user];
    }

    // Bug 5: How to safely pop elements from the array?
    function removeLastNumber() public {
        require(numbers.length > 0, "No numbers in the array");
        numbers.pop();
    }

    function updateBalance(address user, uint amount) public {
        // Task 6: Update balance of a user with a specific amount
        balances[user] += amount;
    }
}
