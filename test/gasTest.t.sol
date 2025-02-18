// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/BuggyContract.sol";

contract GasTest is Test {
    BuggyContract contractInstance;

    function setUp() public {
        contractInstance = new BuggyContract();
    }

    function testIncrementGas() public {
        uint gasUsed = gasleft();
        contractInstance.increment(5);
        gasUsed -= gasleft();
        emit log_named_uint("Gas Used for increment(5)", gasUsed);
    }

    function testDivideGas() public {
        uint gasUsed = gasleft();
        contractInstance.divideCount(2);
        gasUsed -= gasleft();
        emit log_named_uint("Gas Used for divideCount(2)", gasUsed);
    }

    function testSumNumbersGas() public {
        uint gasUsed = gasleft();
        contractInstance.sumNumbers(10);
        gasUsed -= gasleft();
        emit log_named_uint("Gas Used for sumNumbers(10)", gasUsed);
    }

    function testTogglePauseGas() public {
        uint gasUsed = gasleft();
        contractInstance.togglePause();
        gasUsed -= gasleft();
        emit log_named_uint("Gas Used for togglePause()", gasUsed);
    }
}
