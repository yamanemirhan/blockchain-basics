// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Variables {

    uint public myUint = 1; // default: uint256

    // determined by - but not identical to - public key
    // private k. -> public k. -> ethereum address
    address public myAddress = 0x9f1232cA58ed226DB659F5e5C4a36a0D9BE80885;

    function getValue() public pure returns(uint) {
        uint value = 1;
        return value;
    }

    struct MyStruct {
        uint256 myUint256;
        string myString;
    }
    MyStruct public myStruct = MyStruct(1, "Emirhan");

}