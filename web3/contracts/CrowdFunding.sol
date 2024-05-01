// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract CrowdFunding {
    struct Campaign {
        address owner;
        string title;
        string description;
        uint256 target;
        uint256 deadline;
        uint256 amountCollected;
        string image;
        address[] donators;
        uint256[] donations;
    }

    mapping(uint256 => Campaign) public campaigns;

    uint256 public numberOfCampaigns = 0;

    function createCampaign(address _owner, string memory _title, string memory _description, uint256 _target, uint256 _deadline, string memory _image) public returns (uint256){
        //Create a mapping for campaign collections, populating with ZERO
        Campaign storage campaign = campaigns[numberOfCampaigns];

        // In solidity 
        require(campaign.deadline < block.timestamp, "The deadline should be a date in the future.");

        campaign.owner = _owner;
        campaign.title = _title;
        campaign.description = _description;
        campaign.target = _target;
        campaign.deadline = _deadline;
        campaign.amountCollected = 0;
        campaign.image = _image;

        numberOfCampaigns++;

        return numberOfCampaigns - 1;
    }

    function donateToCampaign(uint256 _id) public payable{
        uint256 amount = msg.value;

        Campaign storage campaign = campaigns[_id];

        // Record the address of the sender in the campaign's donators list.
        campaign.donators.push(msg.sender);
        // Record the donated amount in the campaign's donations list.
        campaign.donations.push(amount);

        // Attempt to transfer the donated amount to the campaign owner's address.
        (bool sent,) = payable(campaign.owner).call{value: amount}("");

        // If the funds are successfully sent, increase the total amount collected for the campaign by the donated amount.
        if (sent) {
            campaign.amountCollected = campaign.amountCollected + amount;
        }
    }

    // Define a function to retrieve lists of donators and their donations for a specific campaign.
    function getDonators(uint256 _id) view public returns(address[] memory, uint256[] memory){
        // Return the array of donor addresses and the array of donation amounts for the campaign with the specified ID.
        return (campaigns[_id].donators, campaigns[_id].donations);
    }

    // Define a function to retrieve all campaigns stored in the contract.
    function getCampaigns() public view returns (Campaign[] memory){
        // Create a new dynamic array in memory to store all campaigns, sized to the number of campaigns.
        Campaign[] memory allCampaigns = new Campaign[] (numberOfCampaigns);

        // Iterate over all campaign IDs to populate the allCampaigns array.
        for (uint i = 0; i < numberOfCampaigns; i++){
            // Temporarily store the campaign from the mapping to avoid multiple state reads.
            Campaign storage item = campaigns[i];
            // Assign the campaign to the corresponding index in the array.
            allCampaigns[i] = item;
        }
        // Return the array containing all the campaigns.
        return allCampaigns;
    }
}