// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PrivateStorage {
    uint private storedNumber;
    address public owner;

    // Event emitted when number changes
    event NumberChanged(uint oldNumber, uint newNumber);

    // Constructor: contract deploy होते ही owner set हो जाएगा
    constructor() {
        owner = msg.sender; // deployer = owner
    }

    // Modifier: Only owner can execute
    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner!");
        _;
    }

    // Set number (owner only) + emit event
    function setNumber(uint _num) public onlyOwner {
        uint oldNum = storedNumber;
        storedNumber = _num;
        emit NumberChanged(oldNum, _num);
    }

    // Get number (anyone can read)
    function getNumber() public view returns(uint) {
        return storedNumber;
    }

    // Optional: receive ETH
    receive() external payable {}

    // Get contract balance
    function getBalance() public view returns(uint) {
        return address(this).balance;
    }

    // Optional: withdraw ETH (owner only)
    function withdraw() public onlyOwner {
        payable(owner).transfer(address(this).balance);
    }
}
