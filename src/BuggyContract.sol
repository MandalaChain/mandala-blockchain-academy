// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract BuggyContract {
    uint256 private count = 0;
    string messages;
    bool public isPaused;
    address owner;

    error NotOwner(string);
    error DivisorIsZero(string);

    event ResetNumber(string);

    // I use custom error instead of `require` statement.
    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert NotOwner("Must be an owner!");
        }
        _;
    }

    // Bug 1
    constructor() {
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
        if (divisor == 0) {
            revert DivisorIsZero("Can not be divided by zero!");
        }
        count = count / divisor;
        return count;
    }

    // Bug 5
    // Hint: make sure that message is only stored temporarily
    function setMessage(string memory _message) public pure returns (string memory) {
        return _message;
    }

    // Bug 6
    // Hint: two things to do here.
    // Think about how to make the loop more efficient
    // and read the compiler
    function sumNumbers(uint256 n) public pure returns (uint256) {
        // uint256 sum;
        // for (uint256 i; i <= n; i++) {
        //     sum += i;
        // }

        // I rather use arithmetic sequence formula instead of For Loop.
        // Since we need to sum any numbers from 0 to n, we use the well-known sumatic formula `n * (n + 1) / 2`.
        return (n * (n + 1)) / 2;
    }

    // Bug 7
    // Hint: Think about math operation overflow

    // I haven't figured out what the math operation overflow is yet.
    // So, I let it be, since it doesn't contain error marking. LOL.
    function setCountWithMultiplication(uint256 x, uint256 y) public {
        count = x * y;
    }

    // Bug 8
    // I add an event to log the state.

    // I think we need some `if` checks in here. But, I have no idea. Please suggest some.
    function resetCount() public onlyOwner {
        count = 0;
        emit ResetNumber("The storage has been reset to 0.");
    }

    // Bug 9
    // I don't understand the `Pause` concept for this function.
    // I let it on its initial "buggy" state.
    // Please give some insights.
    function togglePause() public onlyOwner {
        isPaused = isPaused;
    }
}
