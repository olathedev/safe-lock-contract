// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import './lib/Errors.sol';
import './lib/Events.sol';


contract SafeLock {

    struct CreateLock {
        uint256 id;
        string title;
        uint256 amount;
        uint256 duration;
    }

    uint256 _locksIdCounter;

    mapping(address => CreateLock) public safeLocks;

    function createSafeLock(string memory _title, uint256 _durationInDays) external payable {
        if(msg.value < 1) revert Errors.InvalidDepositAmount();
        if(_durationInDays < 10) revert Errors.InvalidLockDuration();

        uint256 timestamp = block.timestamp + (_durationInDays * 1 days);
        
        safeLocks[msg.sender] = CreateLock({
            id: _locksIdCounter++,
            title: _title,
            amount: msg.value,
            duration: timestamp
        });

        emit Events.safeLockCreated(msg.sender, _title, msg.value, timestamp);
    }

    function withdrawLockedFunds() external {
        CreateLock memory userSafeLock = safeLocks[msg.sender];

        if(userSafeLock.amount < 0) revert Errors.NoDepositFound();
        if(userSafeLock.duration < block.timestamp) revert Errors.DepositStillLocked();

        uint256 amount = userSafeLock.amount;
        
        payable(msg.sender).transfer(amount);

        delete safeLocks[msg.sender];

        emit Events.Withdrawn(msg.sender, amount);
    }
    

    
}