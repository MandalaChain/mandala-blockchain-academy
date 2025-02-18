// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract BuggyContract {
    uint private count = 0;
    string messages;
    bool public isPaused;
    address owner;

    error nonZeroNumber(uint256 number, string massage);

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    // Bug 1
    constructor() {
        owner = msg.sender;
    }

    // Bug 2
    function increment(uint amount) internal {
        count += amount;
    }

    // Bug 3
    function getCount() public view returns (uint) {
        return count;
    }

    // Bug 4
    function divideCount(uint divisor) public returns (uint) {
        if (divisor == 0) {
            revert nonZeroNumber(divisor, "Can't divide by zero");
        }
        if (divisor != 0) {
            count = count / divisor;
        }
        return count;
    }

    // Bug 5
    // Hint: make sure that message is only stored temporarily
    function setMessage(string calldata message) public {
        messages = message;
    }

    // Bug 6
    // Hint: two things to do here.
    // Think about how to make the loop more efficient
    // and read the compiler
    function sumNumbers(uint n) public pure returns (uint) {
        if (n == 0) {
            revert nonZeroNumber(n, "Can't sum zero numbers");
        }
        return (n * (n + 1)) / 2; // using arithmetic progression formula
    }

    // Bug 7
    // Hint: Think about math operation overflow
    function setCountWithMultiplication(uint x, uint y) public {
        require(x * y > type(uint).max);
        count = x * y;
    }

    // Bug 8
    function resetCount() internal onlyOwner {
        count = 0;
    }

    // Bug 9
    function togglePause() public onlyOwner {
        isPaused = !isPaused;
    }
}
