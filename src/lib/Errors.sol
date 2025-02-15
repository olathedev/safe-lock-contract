// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;


library Errors {
    error InvalidDepositAmount();
    error InvalidLockDuration();
    error DepositStillLocked();
    error NoDepositFound();
}