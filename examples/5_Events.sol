// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

    // Auction Example
contract Events {
    address public highestBidder;
    uint public highestBid;

    event NewHighBid(address bidder, uint amount);

    constructor() {
        highestBid = 0;
    }

    function bid() public payable {
        require(msg.value > highestBid, "Bid not high enough.");
        if (highestBid != 0) {
            payable(highestBidder).transfer(highestBid);
        }
        highestBidder = msg.sender;
        highestBid = msg.value;
        emit NewHighBid(msg.sender, msg.value);
    }
}

/*
Event Triggering Process:
The event is triggered using the emit keyword.
Event information (parameters) is recorded in the Ethereum transaction log.
This log is permanently stored on the blockchain.

Functions of Events:
a) Notification to the Outside World:
Dapps (decentralized applications) can listen for events.
Example: A transfer event can be used to show real-time notifications in the UI.

b) Alternative Data Storage:
It's a cheaper method of storing data compared to storage.
Example: Details of past transactions can be stored in events.

c) Inter-Contract Communication:
Other smart contracts can detect these events and react to them.

d) Indexable Data:
indexed parameters provide fast search and filtering capabilities.

e) Trigger for Off-chain Operations:
Example: An event can trigger an off-chain service.
*/