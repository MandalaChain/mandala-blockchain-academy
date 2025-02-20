// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract BuggyContract {
    uint private count = 0;
    bool public isPaused;
    address public immutable owner;

    // commented because bug 5 says to make it 'temporary'.
    // string messages;

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    // Bug 1
    constructor() {
        owner = msg.sender;
    }

    /* --------------------------------- EVENTS --------------------------------- */
    event MessageSet(address indexed sender, string message);
    event CountReset(address indexed resetBy);
    event PauseToggled(address indexed toggledBy, bool newState);

    // Bug 2
    function increment(uint amount) private {
        require(amount > 0, "Amount must be greater than 0");

        count += amount;
    }

    // Bug 3
    function getCount() public view returns (uint) {
        return count;
    }

    // Bug 4
    function divideCount(uint divisor) public returns (uint) {
        require(divisor != 0, "Cannot divide by zero");

        unchecked {
            count = count / divisor;
        }

        return count;
    }

    // Bug 5
    // Hint: make sure that message is only stored temporarily
    function setMessage(string memory message) public {
        emit MessageSet(msg.sender, message);
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
    function setCountWithMultiplication(uint x, uint y) public returns (uint) {
        require(x > 0 && y > 0, "Both numbers must be greater than 0");

        unchecked {
            count = x * y;
        }

        return count;
    }

    // Bug 8
    function resetCount() external onlyOwner {
        count = 0;

        emit CountReset(msg.sender);
    }

    // Bug 9
    function togglePause() public onlyOwner {
        isPaused = !isPaused;

        emit PauseToggled(msg.sender, isPaused);
    }
}
