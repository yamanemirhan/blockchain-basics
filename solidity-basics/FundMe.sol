    // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./PriceConverter.sol";

error NotOwner();

contract FundMe {
    using PriceConverter for uint256;

    // 867,987 -> 848,415
    uint256 public constant MIN_USD = 1 * 1e18;

    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    // 2558 -> 444
    address public immutable i_owner;
   
    constructor() {
        i_owner = msg.sender;
    }

    function fund() public payable {
        require(msg.value.getConversionRate() >= MIN_USD, "Didn't send enough");
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    modifier onlyOwner() {
        // require(msg.sender == i_owner, "Only owner can perform this action");
        // 485 -> 213
        if(msg.sender != i_owner){
            revert NotOwner();
        }
        _;
    }

    function withdraw() public onlyOwner {
        for(uint256 funderIndex = 0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        // Blank new array, reset array
        funders = new address[](0);

        // Withdraw
        // 3 ways (transfer, send, call) to send native blockchain currency
        // msg.sender = address, payable(msg.sender) = payable address
        
        // transfer
        // payable(msg.sender).transfer(address(this).balance);
    
        // send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Send failed");

        // call
        (bool callSuccess, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Send failed");
    }

    receive() external payable { fund(); }
    fallback() external payable { fund (); }
}