// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/BuggyContract.sol";

contract BuggyContractTest is Test {
    BuggyContract public buggy;
    address public owner;
    address public user;

    function setUp() public {
        owner = address(this);
        user = address(0x1);
        buggy = new BuggyContract();
    }

    function testIncrement() public {
        buggy.increment(5);
        assertEq(buggy.getCount(), 5);
    }

    function testDivideCount() public {
        buggy.increment(10);
        buggy.divideCount(2);
        assertEq(buggy.getCount(), 5);
    }

    function testFailDivideByZero() public {
        buggy.increment(10);
        buggy.divideCount(0);
    }

    function testSetMessage() public {
        buggy.setMessage("Hello");
    }

    function testSumNumbers() public {
        uint256 result = buggy.sumNumbers(5);
        assertEq(result, 15); // 1 + 2 + 3 + 4 + 5 = 15
    }

    function testSetCountWithMultiplication() public {
        buggy.setCountWithMultiplication(5, 6);
        assertEq(buggy.getCount(), 30);
    }

    function testFailMultiplicationOverflow() public {
        buggy.setCountWithMultiplication(
            type(uint256).max,
            2
        );
    }

    function testResetCount() public {
        buggy.increment(10);
        buggy.resetCount();
        assertEq(buggy.getCount(), 0);
    }

    function testTogglePause() public {
        assertEq(buggy.isPaused(), false);
        buggy.togglePause();
        assertEq(buggy.isPaused(), true);
        buggy.togglePause();
        assertEq(buggy.isPaused(), false);
    }
}