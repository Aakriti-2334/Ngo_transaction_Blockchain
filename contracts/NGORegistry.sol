// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./AccessControl.sol";

contract NGORegistry is AccessControl {
    mapping(address => bool) public approvedNGOs;

    function addNGO(address ngo) external onlyOwner {
        approvedNGOs[ngo] = true;
    }

    function removeNGO(address ngo) external onlyOwner {
        approvedNGOs[ngo] = false;
    }

    function isNGOApproved(address ngo) public view returns (bool) {
        return approvedNGOs[ngo];
    }
}
