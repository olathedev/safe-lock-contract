// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;


library Events {
    event safeLockCreated(address indexed user, string indexed title, uint256 indexed amount, uint256 unlockTime);
    event Withdrawn(address indexed user, uint256 amount);
}