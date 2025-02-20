// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract BuggyContract {
    uint private count = 0;
    string private message;  // Changed from messages to message since we store one at a time
    bool public isPaused;
    address public owner;    // Made owner public for better transparency

    modifier onlyOwner() {  // Added parentheses
        require(msg.sender == owner, "Not owner");  // Added error message
        _;
    }

    // Bug 1 - Fixed constructor syntax
    constructor() {
        owner = msg.sender;
    }

    // Bug 2 - Changed private to public
    function increment(uint amount) public {
        count += amount;
    }

    // Bug 3 - Added public visibility
    function getCount() public view returns (uint) {
        return count;
    }

    // Bug 4 - Added check for division by zero
    function divideCount(uint divisor) public returns (uint) {
        require(divisor > 0, "Cannot divide by zero");
        count = count / divisor;
        return count;
    }

    // Bug 5 - Added memory keyword for temporary storage
    function setMessage(string memory _message) public {
        message = _message;
    }

    // Bug 6 - Optimized sum calculation using mathematical formula
    function sumNumbers(uint n) public pure returns (uint) {
        // Using the formula: sum = n * (n + 1) / 2
        return (n * (n + 1)) / 2;
    }

    // Bug 7 - Added overflow protection by checking multiplication
    function setCountWithMultiplication(uint x, uint y) public {
        uint result = x * y;
        require(result / x == y, "Multiplication overflow");
        count = result;
    }

    // Bug 8 - Added public visibility
    function resetCount() public onlyOwner {
        count = 0;
    }

    // Bug 9 - Fixed toggle logic
    function togglePause() public onlyOwner {
        isPaused = !isPaused;
    }
}