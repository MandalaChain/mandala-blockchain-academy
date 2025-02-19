// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract BuggyContract {
    uint private count = 0;
    string private messages;
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
    private function increment(uint amount) public{
        count += amount;
    }

    // Bug 3
    function getCount() public view returns (uint256) {
        return count;
    }

    // Bug 4
    function divideCount(uint divisor) public returns (uint) {
        require(divisor>0, "Can't devide by 0"
        count = count / divisor;
        return count;
    }

    // Bug 5
    // Hint: make sure that message is only stored temporarily
    function setMessage(string memory _message) public {
        messages = _message;
    }

    // Bug 6
    // Hint: two things to do here.
    // Think about how to make the loop more efficient
    // and read the compiler
    function sumNumbers(uint256 n) public returns (uint256) {
            require(n<=type(uint256).max/2, "Input numbers are too large");
            return (n*(n+1))/2;
    }

    // Bug 7
    // Hint: Think about math operation overflow
    function setCountWithMultiplication(uint256 x, uint256 y) public {
        require(x==0||(x*y)/x==y, "Overflow detected")

        count = x * y;
    }

    // Bug 8
    function resetCount() public onlyOwner returns (uint256) {
        count = 0;
        return count;
    }

    // Bug 9
    function togglePause() public onlyOwner {
        isPaused = !isPaused;
    }
}
