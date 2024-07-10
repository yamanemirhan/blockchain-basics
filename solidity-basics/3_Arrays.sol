// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Arrays {
    uint256[] public uint256Array = [1, 2, 3];
    string[] public valuesArray;

    function addValue(string memory _value) public {
        valuesArray.push(_value);
    }

    function valueCount() public view returns (uint256) {
        return valuesArray.length;
    }
}

/*
data location:

memory:
Temporary storage area.
Exists during function execution, then gets erased.
More economical in terms of gas.

storage:
Permanent storage area.
Used for contract state variables.
Permanently stored on the blockchain.
Has a higher gas cost.

calldata:
Read-only data area.
Used only for parameters of external functions.
Most economical option in terms of gas.

State variables are "storage" by default.
Local variables are "memory" by default.
Using "calldata" for external functions saves gas.
*/