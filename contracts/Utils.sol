// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

library Utils {
    function getCurrentTimestamp() internal view returns (uint256) {
        return block.timestamp;
    }
}
