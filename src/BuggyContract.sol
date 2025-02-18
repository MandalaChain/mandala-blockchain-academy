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
    constructor () {
        owner = msg.sender;
    }

    // Bug 2
    function increment (uint amount) private {
        count += amount;
    }

    // Bug 3
    function getCount() view public returns (uint) {
        return count;
    }

    // Bug 4
    function divideCount(uint divisor) public returns (uint) {
        require(divisor != 0, "divisor shouldn't be 0");
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
    function sumNumbers(uint n) public pure returns (uint) {
        uint sum;
        for (uint i=0; i <= n; i++) {
            sum += i;
        }
        return sum;
    }

    // Bug 7
    // Hint: Think about math operation overflow
    function setCountWithMultiplication(uint x, uint y) public {
        require( y == 0 || x <= type(uint).max / y, "Multiplication may overflow" );
        count = x * y;
    }

    // Bug 8
    function resetCount() onlyOwner public{
        count = 0;
    }

    // Bug 9
    function togglePause() public onlyOwner {
        isPaused = !isPaused;
    }
}
