// SPDX-License-Identifier: MIT
pragma solidity 0.8.26;

import "./ERC20.sol";
import "./Vault.sol";

contract DefiUniversalSports {
    address public manager;
    address[] public participants;
    uint public eventEndTime;
    uint public ticketPrice;
    bool public eventClosed;
    address public champion;

    ERC20 tokenInstance;
    Bank bank;

    constructor() {
        tokenInstance = new ERC20("DEFIUNIVERSE", "DUE");
        bank = new Bank(address(tokenInstance));
        
        manager = msg.sender;
    }

    function depositInBank(uint _tokenAmount) external {
        require(tokenInstance.balanceOf(msg.sender) >= _tokenAmount);
        tokenInstance.transferFunc(msg.sender, address(bank), _tokenAmount);
        
        bank.depositTokens(msg.sender, _tokenAmount);
    }

    function withdrawFromBank() external {
        uint depositedAmount = bank.withdrawTokens(msg.sender);
        uint interest = depositedAmount * 10 / 100;
        tokenInstance.mintTokens(msg.sender, depositedAmount + interest);
    }

    function getBankBalance() external view returns (uint) {
        return bank.bankBalance(msg.sender);
    }

    // pseudo functions
    function transferToOther(address _address, uint _amount) external {
        require(tokenInstance.balanceOf(msg.sender) >= _amount);
        bank.transferFunc(msg.sender, _address, _amount);
    }

    function mint(uint _tokenAmount) external {
        tokenInstance.mintTokens(msg.sender, _tokenAmount);
    }

    function checkBalance() public view returns (uint) {
        return tokenInstance.balanceOf(msg.sender);
    }

    function machineRandomNumber() internal view returns (uint) {
        uint val = uint256(keccak256(abi.encodePacked(block.timestamp, block.coinbase, block.prevrandao, address(this))));
        return val;
    }

    function burnTokens(uint _tokenAmount) public {
        require(tokenInstance.balanceOf(msg.sender) >= _tokenAmount);
        tokenInstance._burn(msg.sender, _tokenAmount);
    }

    function startEvent(uint _durationMin, uint _ticketWei) external {
        eventEndTime = block.timestamp + (_durationMin * 1 minutes);
        ticketPrice = _ticketWei;
        eventClosed = false;
    }

    function buyEventTicket() public payable {
        require(msg.value >= ticketPrice, "Not Enough Wei for Event Ticket");
        uint extraBalance = msg.value - ticketPrice;
        (bool response,) = payable(msg.sender).call{value: extraBalance}("");
        require(response, "Can't return the extra amount");
        require(block.timestamp < eventEndTime, "Event is already ended.");
        require(!eventClosed, "Event is closed.");
        participants.push(msg.sender);
    }

    function pickChampion() public onlyManager {
        require(block.timestamp >= eventEndTime, "Event is still running.");
        require(participants.length > 0, "No participants in the event.");
        require(!eventClosed, "Champion has already been picked.");

        uint championIndex = machineRandomNumber() % participants.length;
        
        champion = participants[championIndex];
        tokenInstance.mintTokens(champion, 10000);
        eventClosed = true;
    }

    modifier onlyManager() {
        require(msg.sender == manager, "Only the manager can call this function.");
        _;
    }

    function getParticipants() public view returns (address[] memory) {
        return participants;
    }

    function timeLeft() public view returns (uint) {
        if (block.timestamp >= eventEndTime) {
            return 0;
        } else {
            return eventEndTime - block.timestamp;
        }
    }
}
