// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract BuggyContract {
    uint256 private count = 0;
    string private message;
    bool public isPaused;
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    modifier whenNotPaused() {
        require(!isPaused, "Contract is paused");
        _;
    }

    // Bug 1
    constructor() {
        owner = msg.sender;
    }

    // Bug 2
    function increment(uint256 amount) public whenNotPaused {
        count += amount;
    }

    // Bug 3
    function getCount() public view returns (uint256) {
        return count;
    }

    // Bug 4
    function divideCount(uint256 divisor) public whenNotPaused returns (uint256) {
        require(divisor > 0, "Cannot divide by zero");
        count = count / divisor;
        return count;
    }

    // Bug 5
    function setMessage(string memory _message) public whenNotPaused {
        message = _message;
    }

    // Bug 6
    function sumNumbers(uint256 n) public pure returns (uint256) {
        require(n <= type(uint256).max / 2, "Number too large");
        return (n * (n + 1)) / 2;
    }

    // Bug 7
    function setCountWithMultiplication(uint256 x, uint256 y) public whenNotPaused {
        require(x*y <= type(uint256).max , "Multiplication is overflow!");
        count = x * y;
    }

    // Bug 8
    function resetCount() public onlyOwner whenNotPaused returns (uint256) {
        count = 0;
        return count;
    }

    // Bug 9
    function togglePause() public onlyOwner {
        isPaused = !isPaused;
    }
}