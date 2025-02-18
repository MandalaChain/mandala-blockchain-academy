// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract BuggyContract {
    uint private count = 0;
    string messages;
    bool public isPaused;
    address owner;

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    // Bug 1 (done)
    constructor() {
        owner = msg.sender;
    }

    // Bug 2 (done)
    function increment(uint amount) private {
        count += amount;
    }

    // Bug 3 (done)
    function getCount() public view returns (uint) {
        return count;
    }

    // Bug 4 (done)
    function divideCount(uint divisor) public returns (uint) {
        require (divisor > 0, "Cannot divide by 0");
        count = count / divisor;
        return count;
    }

    // Bug 5 (done)
    // Hint: make sure that message is only stored temporarily
    function setMessage(string memory message) public {
        messages = message;
    }

    // Bug 6 (done)
    // Hint: two things to do here.
    // Think about how to make the loop more efficient
    // and read the compiler
    function sumNumbers(uint n) public pure returns (uint) {
        return (n * (n + 1)) / 2;
    }

    // Bug 7 (done)
    // Hint: Think about math operation overflow
    function setCountWithMultiplication(uint x, uint y) public {
        unchecked {
            count = x * y;
        }
    }

    // Bug 8 (done)
    function resetCount() public onlyOwner {
        count = 0;
    }

    // Bug 9 (done)
    function togglePause() public onlyOwner {
        isPaused = !isPaused;
    }
}
