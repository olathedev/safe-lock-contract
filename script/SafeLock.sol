// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import './lib/Errors.sol';
import './lib/Events.sol';


contract TimeVest {
    struct Lock {
        uint256 id;
        string title;
        uint256 amount;
        uint256 duration;
    }

    uint256 _locksIdCounter;

    mapping(address => Lock) safeLocks;

    function createSafeLock(string memory _title, uint256 _durationInDays) external payable {
        if(msg.value < 0) revert Errors.InvalidDepositAmount();
        if(_durationInDays < 10) revert Errors.InvalidLockDuration();

        uint256 timestamp = block.timestamp + (_durationInDays * 1 days);

        safeLocks[msg.sender] = Lock({
            id: _locksIdCounter + 1,
            title: _title,
            amount: msg.value,
            duration: timestamp
        });

        emit Events.safeLockCreated(msg.sender, _title, msg.value, timestamp);
    }

    


}