// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract TimeVest {
    struct Lock {
        string title;
        uint256 amout;
        uint256 duration;
    }

    mapping(address => Lock) safeLocks;

    function createSafeLock(string memory _title, uint256 _durationInDays) external payable {
        
    }
}