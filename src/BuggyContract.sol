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
    // In the constructor, there is no constructor keyword, causing a syntax error
    constructor() {
        owner = msg.sender;
    }

    // Bug 2
    // The increment function is declared as private and function instead of function and should be internal for broader access within the contract
    function increment(uint amount) internal {
    count += amount;
    }

    // Bug 3
    // The getCount function is missing the view modifier and the return type
    function getCount() public view returns (uint) {
    return count;
    }


    // Bug 4
    // The divideCount function is allowing division by zero, which will cause a runtime exception. You should add a check to ensure the divisor is not zero
    function divideCount(uint divisor) public returns (uint) {
    require(divisor != 0, "Cannot divide by zero");
    count = count / divisor;
    return count;
    }


    // Bug 5
    // The messages variable is being set directly in the setMessage function, which may cause it to persist permanently. We want to store it temporarily. You could add an event to emit the message or even use a memory keyword for temporary storage, but it’s best to store it and later use it for other purposes if needed
    // Hint: make sure that message is only stored temporarily
    function setMessage(string memory message) public {
    messages = message;
    }


    // Bug 6
    // Hint: two things to do here.
    // Think about how to make the loop more efficient
    // and read the compiler
    // The loop condition i <= n in the sumNumbers function will result in an off-by-one error, as i starts at 0, so the loop will run n + 1 times. Also, it’s more efficient to change the loop type to uint with a fixed increment
    function sumNumbers(uint n) public returns (uint) {
    uint sum;
    for (uint i = 1; i <= n; i++) {
        sum += i;
    }
    return sum;
    }


    // Bug 7
    // Hint: Think about math operation overflow
    // There is a potential overflow issue with setCountWithMultiplication. In Solidity, arithmetic operations could overflow or underflow if the result exceeds the range of the variable type. The SafeMath library can be used to prevent overflow, but from Solidity 0.8.0 and above, overflow checks are built-in by default

    function setCountWithMultiplication(uint x, uint y) public {
    require(x == 0 || y == 0 || x * y / x == y, "Overflow detected");
    count = x * y;
    }


    // Bug 8
    // The resetCount function has no visibility modifier. It should be marked public or external
    function resetCount() public onlyOwner {
    count = 0;
    }


    // Bug 9
    // The togglePause function doesn't actually toggle the isPaused state. You need to assign the opposite value
    function togglePause() public onlyOwner {
    isPaused = !isPaused;
    }
}
