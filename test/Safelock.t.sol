// SPDX-License-Identifier: MIT

pragma solidity ^0.8.23;

import { Test } from "forge-std/Test.sol";
import '../src/Safelock.sol';
import '../src/lib/Errors.sol';

contract SafeLockTest is Test {
    SafeLock safeLock;

    address user = address(1);
    struct CreateLock {
        uint256 id;
        string title;
        uint256 amount;
        uint256 duration;
    }

    function setUp() public {
        safeLock = new SafeLock();
    }

    function testDeployment() public view {
        // not using the usual owner check cause im not assignging owner in my contract
        assertEq(address(this) != address(0), true, "Contract deploymet failed");
    }

    function testRevertIfZeroAmount() public {
        vm.startPrank(user);
        uint256 duration = 10;
        vm.expectRevert(Errors.InvalidDepositAmount.selector);
        safeLock.createSafeLock("Valentine savings", duration);

        vm.stopPrank();
    }

    function testRevertIfLockDurationLessThan10() public {
        vm.startPrank(user);
        
        uint256 duration = 5;
        uint256 amount = 1 ether;

        vm.deal(user, 2 ether);
        vm.expectRevert(Errors.InvalidLockDuration.selector);
        safeLock.createSafeLock{value: amount}("Valentine savings", duration);
        vm.stopPrank();
    }

    function testSuccessfulCreationOfSafeLock() public {
        vm.startPrank(user);

        vm.deal(user, 2 ether);

        safeLock.createSafeLock{value: 1 ether}("Money for lambo", 30);
        
        
        (uint256 id, string memory title, uint256 amount, uint256 duration) = safeLock.safeLocks(user);
                    
        assertEq(amount, 1 ether, "unable to create safelock");
        vm.stopPrank();
    }



    

}
