// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract DonorRegistry {
    struct Donor {
        address donor;
        uint256 totalDonated;
        uint256 donationsCount;
    }

    mapping(address => Donor) public donorData;

    function updateDonor(address _donor, uint256 amount) internal {
        donorData[_donor].donor = _donor;
        donorData[_donor].totalDonated += amount;
        donorData[_donor].donationsCount += 1;
    }

    function getDonorInfo(address _donor) external view returns (uint256, uint256) {
        Donor memory d = donorData[_donor];
        return (d.totalDonated, d.donationsCount);
    }
}
