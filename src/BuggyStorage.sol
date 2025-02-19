// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BuggyStorage {
    // DO NOT EDIT COMMENTS
    // Task 1: Declare an array as numbers;
    // Task 2: Declare a string as message;
    // Task 3: Declare a mapping of address to balance as balances;

    uint256[] private _numbers;
    string private _message;
    mapping(address => uint256) private _balances;

    // Bug 1: Array bounds
    function getNumber(uint256 index) public view returns (uint256) {
        require(index < _numbers.length, "Inputted index is not available");

        return _numbers[index];
    }

    function addNumber(uint256 number) public {
        // Task 4: Implement adding numbers to the array
        _numbers.push(number);
    }

    // Bug 2: Slice array correctly
    function sliceArray(uint256 start, uint256 end)
        public
        view
        returns (uint256[] memory)
    {
        require(start < end, "Start index must be less than end index");
        require(end <= _numbers.length, "End index out of range");

        uint256[] memory _slicedArr = new uint256[](end - start);
        for (uint256 i = start; i < end; i++) {
            _slicedArr[i - start] = _numbers[i];
        }

        return _slicedArr;
    }

    // Bug 3: Concatenate strings correctly
    function setMessage(string memory newMessage) public {
        _message = string(abi.encodePacked(_message, newMessage));
    }

    // Bug 4: How do we update numbers with memory as params?
    function validMemoryUsage(uint256[] memory input) public {
        // Implement logics to update numbers here
        delete _numbers;

        for (uint256 i = 0; i < input.length; i++) {
            _numbers.push(input[i]);
        }
    }

    function getBalance(address user) public view returns (uint256) {
        // Task 5: Returning the balance for a specific user
        return _balances[user];
    }

    // Bug 5: How to safely pop elements from the array?
    function removeLastNumber() public {
        require(
            _numbers.length > 0,
            "Array cannot be popped, caused by array is empty"
        );
        _numbers.pop();
    }

    function updateBalance(address user, uint256 amount) public {
        // Task 6: Update balance of a user with a specific amount
        _balances[user] = amount;
    }
}
