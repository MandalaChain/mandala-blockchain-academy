// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract BuggyContract {
    uint private count = 0;
    // Removed the persistent "messages" storage variable.
    bool public isPaused;
    address owner;

    // Event to log messages temporarily (Bug 5 fix)
    event MessageSet(string message);

    modifier onlyOwner {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    // Bug 1 Fix:
    // Use the proper constructor syntax so that the owner is set at deployment.
    constructor() {
        owner = msg.sender;
    }

    // Bug 2 Fix:
    // Correct the function declaration syntax and placement of the "private" keyword.
    function increment(uint amount) private {
        count += amount;
    }

    // Bug 3 Fix:
    // Explicitly set the function's visibility (public) so others can call it.
    function getCount() public view returns (uint) {
        return count;
    }

    // Bug 4 Fix:
    // Add a require statement to prevent division by zero.
    function divideCount(uint divisor) public returns (uint) {
        require(divisor != 0, "Divisor cannot be zero");
        count = count / divisor;
        return count;
    }

    // Bug 5 Fix:
    // Instead of storing the message permanently in a state variable,
    // emit it via an event. Also, mark the parameter as "memory" to indicate it's temporary.
    function setMessage(string memory message) public {
        emit MessageSet(message);
    }

    // Bug 6 Fix:
    // Instead of looping to sum numbers, use the arithmetic formula:
    // Sum of numbers from 0 to n is n*(n+1)/2. Also, mark the function as pure.
    function sumNumbers(uint n) public pure returns (uint) {
        return n * (n + 1) / 2;
    }

    // Bug 7 Fix:
    // Solidity 0.8+ has built-in overflow checks. Optionally, you can add a check,
    // but here we rely on the compiler's safety. The code remains largely the same.
    function setCountWithMultiplication(uint x, uint y) public {
        // The multiplication will revert on overflow.
        uint product = x * y;
        count = product;
    }

    // Bug 8 Fix:
    // Specify the visibility (public) so that the function can be called.
    function resetCount() public onlyOwner {
        count = 0;
    }

    // Bug 9 Fix:
    // Toggle the boolean value by using the NOT operator.
    function togglePause() public onlyOwner {
        isPaused = !isPaused;
    }
}
