// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Mappings {
    mapping(uint => string) public names;

    constructor() {
        names[0] = "Emirhan";
        names[1] = "John";
    }
    
    mapping(uint => Book) public books;
    mapping(address => mapping(uint => Book)) public myBooks;

    struct Book {
        string title;
        string author;
    }

    function addBook(uint _id, string memory _title, string memory _author) public{
        books[_id] = Book(_title, _author);
    }

    function addMyBook(
        uint256 _id,
        string memory _title,
        string memory _author
    ) public {
        myBooks[msg.sender][_id] = Book(_title, _author);
        // global variable: msg.sender (address): sender of the message (current call)
        // for exp: msg.value (uint): number of wei sent with the message
    }
}