// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract BuggyContract {
    uint256 private count = 0;
    string messages;
    bool public isPaused;
    address owner;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    // Bug 1
    function setOwner() public {
        owner = msg.sender;
    }

    // Bug 2
    function increment(uint256 amount) private {
        count += amount;
    }

    // Bug 3
    function getCount() public view returns (uint256) {
        return count;
    }

    // Bug 4
    function divideCount(uint256 divisor) public returns (uint256) {
        require(divisor != 0, "Divisor cannot be zero");
        count = count / divisor;

        return count;
    }

    // Bug 5
    // Hint: make sure that message is only stored temporarily
    function setMessage(string memory message) public {
        messages = message;
    }

    // Bug 6
    // Hint: two things to do here.
    // Think about how to make the loop more efficient
    // and read the compiler
    function sumNumbers(uint256 n) public pure returns (uint256) {
        return (n * (n + 1)) / 2;
    }

    // Bug 7
    // Hint: Think about math operation overflow
    function setCountWithMultiplication(uint x, uint y) public {
        uint result = x * y;
        require(y == 0 || result / y == x, "Multiplication overflow");
        count = result;
    }

    // Bug 8
    function resetCount() public onlyOwner {
        count = 0;
    }

    // Bug 9
    function togglePause() public onlyOwner {
        isPaused = !isPaused;
    }
}
