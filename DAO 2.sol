pragma solidity ^0.8.18;

contract DAO {
    mapping(address => uint256) public expertTimeSpent;
    mapping(address => uint256) public expertExpertise;
    mapping(address => uint256) public expertFTE;
    uint256 public minimumSalary;

    event ExpertCompensated(address indexed expert, uint256 compensation);

    constructor(uint256 _initialMinimumSalary) {
        minimumSalary = _initialMinimumSalary;
    }

    function compensateExpert(address payable expert) public {
        uint256 compensation = (expertTimeSpent[expert] * expertExpertise[expert] * minimumSalary) / (100 * expertFTE[expert]);
        expert.transfer(compensation);
        emit ExpertCompensated(expert, compensation);
    }

    function reportTimeSpent(uint256 time) public {
        expertTimeSpent[msg.sender] += time;
    }

    function setExpertise(uint256 level) public {
        expertExpertise[msg.sender] = level;
    }

    function setFTE(uint256 fte) public {
        expertFTE[msg.sender] = fte;
    }
}