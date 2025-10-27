// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title CryptexaLabs
 * @dev A decentralized platform for funding and tracking blockchain-based research projects.
 */
contract CryptexaLabs {
    struct Project {
        uint256 id;
        string title;
        address creator;
        uint256 funds;
    }

    mapping(uint256 => Project) public projects;
    uint256 public totalProjects;

    event ProjectCreated(uint256 indexed id, string title, address indexed creator);
    event FundAdded(uint256 indexed id, uint256 amount, address indexed funder);

    /**
     * @dev Create a new research project.
     * @param _title The title of the project.
     */
    function createProject(string memory _title) public {
        totalProjects++;
        projects[totalProjects] = Project(totalProjects, _title, msg.sender, 0);
        emit ProjectCreated(totalProjects, _title, msg.sender);
    }

    /**
     * @dev Fund an existing project.
     * @param _id The ID of the project.
     */
    function fundProject(uint256 _id) public payable {
        require(_id > 0 && _id <= totalProjects, "Invalid project ID");
        require(msg.value > 0, "Funding amount must be greater than zero");

        projects[_id].funds += msg.value;
        emit FundAdded(_id, msg.value, msg.sender);
    }

    /**
     * @dev Get project details.
     * @param _id The ID of the project.
     * @return id, title, creator, total funds collected.
     */
    function getProject(uint256 _id)
        public
        view
        returns (uint256, string memory, address, uint256)
    {
        require(_id > 0 && _id <= totalProjects, "Project does not exist");
        Project memory p = projects[_id];
        return (p.id, p.title, p.creator, p.funds);
    }
}

