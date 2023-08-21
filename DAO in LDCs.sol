pragma solidity ^0.8.18;

contract DAO {
    mapping(address => uint256) public voterStake;
    mapping(address => uint256) public voterExpertise;
    uint256 public totalStake;

    function vote(bool supportsProposal) public {
        uint256 weight = (voterStake[msg.sender] * voterExpertise[msg.sender]) / 100;
        if (supportsProposal) {
            totalStake += weight;
        } else {
            totalStake -= weight;
        }
    }

    function deposit() public payable {
        voterStake[msg.sender] += msg.value;
        totalStake += msg.value;
    }

    function setExpertise(uint256 level) public {
        voterExpertise[msg.sender] = level;
    }
}