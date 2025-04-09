// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "./AccessControl.sol";
import "./DonorRegistry.sol";
import "./NGORegistry.sol";
import "./Utils.sol";

contract DonationVerifier is DonorRegistry, NGORegistry {
    using Utils for uint256;

    struct Donation {
        address donor;
        uint256 amount;
        uint256 timestamp;
    }

    Donation[] public donations;
    uint256 public totalDonations;

    event DonationReceived(address indexed donor, uint256 amount, uint256 timestamp);
    event Withdrawal(address indexed ngo, uint256 amount);

    function donate() external payable {
        require(msg.value > 0, "Donation must be greater than 0");

        donations.push(Donation(msg.sender, msg.value, block.timestamp));
        totalDonations += msg.value;

        updateDonor(msg.sender, msg.value);

        emit DonationReceived(msg.sender, msg.value, block.timestamp);
    }

    function withdraw(uint256 amount) external {
        require(isNGOApproved(msg.sender), "NGO not approved");
        require(amount <= address(this).balance, "Insufficient balance");

        payable(msg.sender).transfer(amount);
        emit Withdrawal(msg.sender, amount);
    }

    function getDonationsCount() external view returns (uint256) {
        return donations.length;
    }

    function getDonation(uint index) external view returns (address, uint256, uint256) {
        require(index < donations.length, "Invalid index");
        Donation memory d = donations[index];
        return (d.donor, d.amount, d.timestamp);
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
