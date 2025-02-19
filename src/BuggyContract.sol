// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract BuggyContract {
    uint private count = 0;
    string messages;
    bool public isPaused;
    address owner;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    // Bug 1 : need add contructor
    constructor() {
        owner = msg.sender;
    }

    // Bug 2 : the function increment visibility should be 'internal' instead of 'private'
    function increment(uint amount) internal {
        count += amount;
    }

    // Bug 3 : the function getCount must specify visibility
    function getCount() public view returns (uint) {
        return count;
    }

    // Bug 4 : Prevention validate division by zero
    function divideCount(uint divisor) public returns (uint) {
        require(divisor != 0, "Cannot divide by zero");
        count = count / divisor;
        return count;
    }

    // Bug 5 : the string need use memory in storage
    // Hint: make sure that message is only stored temporarily
    // please use memory instead of storing the string in storage
    function setMessage(string memory message) public {
        messages = message;
    }

    // Bug 6 : Fix looping initialization and refactor optimize looping
    // Hint: two things to do here.
    // Think about how to make the loop more efficient
    // and read the compiler
    function sumNumbers(uint n) public pure returns (uint) {
        // using formula Gauss because more efficient and avoids high gas fee
        return (n * (n + 1)) / 2;
    }

    // Bug 7 : the prevention validate overflow using safemath
    // Hint: Think about math operation overflow
    function setCountWithMultiplication(uint x, uint y) public {
        require(
            y == 0 || x <= type(uint).max / y,
            "math operation multiplication overflow"
        );
        count = x * y;
    }

    // Bug 8 : this function resetCount must add 'public' visibility
    function resetCount() public onlyOwner {
        count = 0;
    }

    // Bug 9 : Toggle should be switch on/off states correctly
    function togglePause() public onlyOwner {
        isPaused = !isPaused;
    }
}
