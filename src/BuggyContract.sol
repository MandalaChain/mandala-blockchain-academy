// SPDX-License-Identifier: MIT
pragma solidity 0.8.28;

//homework owner = Putu Gde Trahwidhi

contract BuggyContract {
    uint private count = 0;
    string messages;
    bool public isPaused;
    address owner;

    //bug number 4 custom error
    error zeroDivision(uint divisor);
    error overflow(uint x, uint y);

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    // Bug 1
    // saya pakai constructor karena saya anggap kode ini best practice di contructor, kalau pakai function juga bisa
    constructor() {
        owner = msg.sender;
    }

    // Bug 2
    function increment(uint amount) private {
        count += amount;
    }

    // Bug 3
    function getCount() external view returns (uint) {
        return count;
    }

    // Bug 4
    function divideCount(uint divisor) public returns (uint) {
        if(divisor == 0){
            revert zeroDivision(divisor);
        }
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
        uint sum = 0;
        for (uint i; i <= n; i++) {
            sum += i;
        }
        return sum;
    }

    // Bug 7
    // Hint: Think about math operation overflow
    // this is better because i put the formula in result variable so i can check (error handling) first then assign it to count
    function setCountWithMultiplication(uint x, uint y) public {
        uint256 result = x * y;
        if(x != 0 && result / x != y){
            revert overflow(x, y);
        }
        count = result;
    }

    // Bug 8
    function resetCount() external onlyOwner {
        count = 0;
    }

    // Bug 9
    //boolean true and false, with ! i can make it go true and false
    function togglePause() public onlyOwner {
        isPaused = !isPaused;
    }
}