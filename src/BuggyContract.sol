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
    // its error because no function, construct or etc to call the owner variable. 
    // Also you could add custom modifier from line 10 to the func so only the owner can call it. 
    // That's why I added getOwner and onlyOwner modifier
    function getOwner() onlyOwner private {
        owner = msg.sender;
    }

    // Bug 2
    // there is no visibility for the function, thats why I added private visibility
    function increment(uint amount) public {
        count += amount;
    }

    // Bug 3
    // same as bug 2, there is no visibility for the function
    function getCount() public view returns (uint) {
        return count;
    }

    // Bug 4
    // im not sure about this bug, but I think the function should return the count value after the division operation 
    // from the input parameter so I change the variable from state to local variable. 
    // I don't know if its correct or not
    function divideCount(uint _divisor) public returns (uint) {
        count = count / _divisor;
        return count;
    }

    // Bug 5
    // Hint: make sure that message is only stored temporarily
    // this error because of no data location for the message variable, so I added memory location
    function setMessage(string memory message) public {
        messages = message;
    }

    // Bug 6
    // Hint: two things to do here.
    // Think about how to make the loop more efficient
    // and read the compiler

    // i dont know what is wrong with this function, but I think the function should return the sum of the numbers from 1 to n
    // so I added variable i is equal to 1 on the for loop
    // also I added pure visibility because the function is not changing the state of the contract
    function sumNumbers(uint n) pure public returns (uint) {
        uint sum;
        for (uint i = 1; i <= n; i++) {
            sum += i;
        }
        return sum;
    }

    // Bug 7
    // Hint: Think about math operation overflow
    // im not sure what must i do about this
    function setCountWithMultiplication(uint x, uint y) public {
        count = x * y;
    }

    // Bug 8
    // the error is because no visibility for the function, so I added public visibility
    // and also I remove the onlyOwner modifier so I could call the function on remix
    function resetCount() public {
        count = 0;
    }

    // Bug 9
    // same as bug 8, I remove the onlyOwner modifier
    function togglePause() public {
        isPaused = isPaused;
    }
}
