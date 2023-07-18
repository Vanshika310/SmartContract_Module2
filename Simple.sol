// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract Permission {
    mapping(address => bool) private permissions;

    event PermissionSet(address indexed account, bool hasPermission);

    constructor() {
        permissions[msg.sender] = true; // Set contract deployer's address as initially having permission
    }

    modifier onlyOwner() {
        require(permissions[msg.sender], "Only the contract owner can set permissions");
        _;
    }

    function setPermissionForAddress(address account, bool hasPermission) external onlyOwner {
        permissions[account] = hasPermission;
        emit PermissionSet(account, hasPermission);
    }

    function checkPermissionForAddress(address account) public view returns (bool) {
        return permissions[account];
    }
}
