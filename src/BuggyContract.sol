// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

contract BuggyContract {
    uint private count = 0;
    string private message;  
    bool public isPaused;
    address public owner;   

    modifier onlyOwner() {  
        require(msg.sender == owner, "Not owner");  
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function increment(uint amount) public {
        count += amount;
    }

    function getCount() public view returns (uint) {
        return count;
    }

    function divideCount(uint divisor) public returns (uint) {
        require(divisor > 0, "Cannot divide by zero");
        count = count / divisor;
        return count;
    }

    function setMessage(string memory _message) public {
        message = _message;
    }

    function sumNumbers(uint n) public pure returns (uint) {
        return (n * (n + 1)) / 2;
    }

    function setCountWithMultiplication(uint x, uint y) public {
        uint result = x * y;
        require(result / x == y, "Multiplication overflow");
        count = result;
    }

    function resetCount() public onlyOwner {
        count = 0;
    }

    function togglePause() public onlyOwner {
        isPaused = !isPaused;
    }
}