// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
Function Modifiers:
view: Does not modify the contract state, only reads from it.
pure: Neither reads from nor modifies the contract state.
payable: Indicates functions that can receive Ether.
*/

/*
Visibility Specifiers:
public: Accessible both externally and from within the contract.
private: Accessible only from within the contract where it's defined.
internal: Accessible from the contract where it's defined and contracts deriving from it.
external: Can only be called from outside the contract, not accessible internally.
*/

/*
State Variables - Local Variables
1. Defined at the contract level. - Defined within a function.
2. Permanently stored on the blockchain. - Only usable within the function where they are defined.
3. Accessible by all functions within the contract. - Destroyed when the function execution ends.
4. Higher gas cost. - Lower gas cost.
5. Values are preserved throughout the contract's lifecycle. - Stored in temporary storage (memory).
*/

/*
Q: Gas calculation?
*/