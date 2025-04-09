// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract AccessControl {
    address public owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }
}
