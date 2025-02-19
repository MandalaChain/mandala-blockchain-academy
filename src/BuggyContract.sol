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

    // Bug 1
    constructor() {
        owner = msg.sender;
    }

    // Bug 2
    private increment(uint amount) public {
        count += amount;
    }

    // Bug 3
    function getCount() view public returns (uint) {
        return count;
    }

    // Bug 4
    function divideCount(uint divisor) public returns (uint) {
        require(divisor !=0, "Divisor cannot be zero");
        count = count / divisor;
        return count;
    }

    // Bug 5
    // Hint: make sure that message is only stored temporarily
    string public tempMessage;
    function setMessage(string memory message) public {
        tempMessages = message;
    }

    // Bug 6
    // Hint: two things to do here.
    // Think about how to make the loop more efficient
    // and read the compiler
    function sumNumbers(uint n) public pure returns (uint) {
        return (n * (n + 1)) / 2;
        }

    // Bug 7
    // Hint: Think about math operation overflow
    require(x == 0 || (x * y) / x == y, "Multiplication overflow");
    function setCountWithMultiplication(uint x, uint y) public {
        count = x * y;
    }

    // Bug 8
    uint public count;
    function resetCount() public onlyOwner {
        count = 0;
    }

    // Bug 9
    bool public isPaused;
    function togglePause() public onlyOwner {
        isPaused = !isPaused;
    }
}
