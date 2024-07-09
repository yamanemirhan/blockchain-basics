// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Receive_Fallback {
    uint256 public result;

    // Will trigger if calldata is blank
    // It can be virtual, can override and can have modifiers
    receive() external payable {
        result = 1;
    }

    fallback() external payable {
        result = 2;
    }
}