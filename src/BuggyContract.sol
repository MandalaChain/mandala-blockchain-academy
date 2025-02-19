// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract BuggyContract {
    uint256 private count = 0;
    string messages;
    bool public isPaused;
    address owner;

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    // Bug 1 - done
    function setOwner() public {
        owner = msg.sender;
    }

    // Bug 2 - done
    function increment(uint256 _amount) private {
        count += _amount;
    }

    // Bug 3 - done
    function getCount() public view returns (uint256) {
        return count;
    }

    // Bug 4 - done
    function divideCount(uint256 _divisor) public returns (uint256) {
        count = count / _divisor;
        return count;
    }

    // Bug 5 - done
    // Hint: make sure that message is only stored temporarily
    function setMessage(string memory _message) public {
        messages = _message;
    }

    // Bug 6 - done
    // Hint: two things to do here.
    // Think about how to make the loop more efficient
    // and read the compiler
    function sumNumbers(uint256 _n) public pure returns (uint256) {
        uint256 sum = 0;
        for (uint256 i = 0; i <= _n; i++) {
            sum += i;
        }
        return sum;
    }

    // Bug 7 - done
    // Hint: Think about math operation overflow
    function setCountWithMultiplication(uint256 _x, uint256 _y) public {
        unchecked { count = _x * _y; }
    }

    // Bug 8 - done
    function resetCount() public onlyOwner {
        count = 0;
    }

    // Bug 9 - done
    function togglePause() public onlyOwner {
        isPaused = !isPaused;
    }
}
