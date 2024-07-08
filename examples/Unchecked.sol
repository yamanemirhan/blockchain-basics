// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Unchecked {
    uint8 public bigNumber = 255;

    function add() public {
        unchecked {bigNumber++;}
    }
}