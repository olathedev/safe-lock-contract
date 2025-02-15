// SPDX-License-Identifier: MIT

pragma solidity ^0.8.23;

import { Test } from "forge-std/Test.sol";
import '../src/Safelock.sol';
import '../src/lib/Errors.sol';

contract SafeLockTest is Test {
    SafeLock safeLock;

    address owner = address(1);

    function setUp() public {
        safeLock = new SafeLock();
    }

    function testDeployment() public view {
        assertEq(address(this) != address(0), true, "Contract deploymet failed");
    }

}
