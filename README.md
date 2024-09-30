Here's a README template based on the commands you ran on Ubuntu and the setup of your Avalanche blockchain. You can customize it further as needed.

---

# Avalanche Subnet Setup

This document outlines the steps to set up an Avalanche subnet named `hrishikeshsubnet` on an Ubuntu environment, along with relevant commands and outputs.

## Prerequisites

Ensure you have the following installed:
- [Ubuntu](https://ubuntu.com/)
- [Avalanche CLI](https://docs.avax.network/learn/avalanche-cli)

## Installation Steps

1. **Install Avalanche CLI**

   Run the following command to install Avalanche CLI:

   ```bash
   curl -sSfL https://raw.githubusercontent.com/ava-labs/avalanche-cli/main/scripts/install.sh | sh -s ava-labs/avalanche-cli
   ```

   **Output:**
   ```
   info checking GitHub for latest tag
   info found version: 1.7.5 for linux/amd64
   info installed /home/hrishikesh/bin/avalanche
   ```

2. **Create a New Subnet**

   Use the command below to create a new blockchain configuration:

   ```bash
   avalanche blockchain create hrishikeshsubnet
   ```

   **Output:**
   ```
   ✔ Subnet-EVM
   I want to use defaults for a test environment
   Chain ID: 14042
   Token Symbol: HRM3
   prefunding address 0x8db97C7cEcE249c2b98bDC0226Cc4C2A57BF52FC with balance 1000000000000000000000000
   creating genesis for blockchain hrishikeshsubnet
   ✓ Successfully created blockchain configuration
   ```

3. **Deploy the Subnet**

   Deploy the newly created subnet with the following command:

   ```bash
   avalanche blockchain deploy hrishikeshsubnet
   ```

   **Output:**
   ```
   ✔ Local Network
   Deploying [hrishikeshsubnet] to Local Network
   Booting Network. Wait until healthy...
   Teleporter Messenger successfully deployed to c-chain (0x253b2784c75e510dD0fF1da844684a1aC0aa5fcf)
   Teleporter Registry successfully deployed to c-chain (0x17aB05351fC94a1a67Bf3f56DdbB941aE6c63E25)
   Blockchain ready to use
   ```

4. **View Blockchain Information**

   You can check the details of your blockchain using:

   ```bash
   avalanche blockchain list
   ```

   **Output:**
   ```
   +------------------+------------------+----------+---------------------------------------------------+------------+------------+-----------+
   |      SUBNET      |      CHAIN       | CHAINID  |                       VMID                        |    TYPE    | VM VERSION | FROM REPO |
   +------------------+------------------+----------+---------------------------------------------------+------------+------------+-----------+
   | hrishikeshSubnet | hrishikeshSubnet |    14042 | nzxURfeht7efcw5M8Kj8uDF4oNVqCZXqNaNvst3v2mrjfwYcr | Subnet-EVM | v0.6.8     | false     |
   +------------------+------------------+----------+---------------------------------------------------+------------+------------+-----------+
   ```

## Token Information

- **Token Name:** HRM3 Token
- **Token Symbol:** HRM3
- **Initial Token Allocation:** 1000000 HRM3 to the prefunding address

## Node Information

- **Node Endpoints:**
  - Node 1: [http://127.0.0.1:9650](http://127.0.0.1:9650)
  - Node 2: [http://127.0.0.1:9652](http://127.0.0.1:9652)
  - Node 3: [http://127.0.0.1:9654](http://127.0.0.1:9654)
  - Node 4: [http://127.0.0.1:9656](http://127.0.0.1:9656)
  - Node 5: [http://127.0.0.1:9658](http://127.0.0.1:9658)

Here's a sample README for your `DefiUniversalSports` smart contract, providing an overview of the project, its functionality, and instructions on how to use it.

---

# DefiUniversalSports Smart Contract

## Overview

The `DefiUniversalSports` smart contract is a decentralized finance (DeFi) application built on the Ethereum blockchain. It allows users to participate in a sporting event by purchasing tickets with Ether (ETH) and rewards a randomly selected champion with tokens. The contract integrates an ERC20 token and a bank contract for managing deposits and withdrawals.

## Features

- **ERC20 Token Integration**: The contract creates an ERC20 token called **DEFIUNIVERSE (DUE)** for reward distribution.
- **Banking Functionality**: Users can deposit tokens into a bank and withdraw them with interest.
- **Event Management**: The contract allows the manager to start events, buy tickets, and select champions.
- **Random Champion Selection**: A pseudo-random number generator determines the champion among participants.
- **Interest on Deposits**: Users earn a 10% interest on their deposited amount when they withdraw.

## Contract Structure

### Variables
- `manager`: Address of the contract manager.
- `participants`: Array of participant addresses.
- `eventEndTime`: Timestamp for when the event ends.
- `ticketPrice`: Price of the event ticket in wei.
- `eventClosed`: Flag indicating if the event is closed.
- `champion`: Address of the winning participant.

### Functions

1. **Constructor**
   - Initializes the contract, creating an ERC20 token and a bank instance.

2. **depositInBank(uint _tokenAmount)**
   - Deposits tokens into the bank.

3. **withdrawFromBank()**
   - Withdraws tokens with interest from the bank.

4. **getBankBalance()**
   - Returns the user's bank balance.

5. **transferToOther(address _address, uint _amount)**
   - Transfers tokens to another address.

6. **mint(uint _tokenAmount)**
   - Mints new tokens to the caller's address.

7. **checkBalance()**
   - Returns the caller's token balance.

8. **machineRandomNumber()**
   - Generates a pseudo-random number for champion selection.

9. **burnTokens(uint _tokenAmount)**
   - Burns the specified amount of tokens from the caller's address.

10. **startEvent(uint _durationMin, uint _ticketWei)**
    - Starts a new event with a specified duration and ticket price.

11. **buyEventTicket()**
    - Allows participants to buy tickets for the event.

12. **pickChampion()**
    - Randomly selects a champion after the event ends.

13. **getParticipants()**
    - Returns the list of participants.

14. **timeLeft()**
    - Returns the remaining time until the event ends.

### Modifiers

- **onlyManager**: Restricts function access to the manager only.

## Usage

1. **Deploy the Contract**
   - Deploy the `DefiUniversalSports` contract on the Ethereum network.

2. **Token Management**
   - Use `depositInBank` to deposit tokens.
   - Call `withdrawFromBank` to withdraw tokens along with interest.

3. **Event Participation**
   - Call `startEvent` to initialize an event.
   - Participants can use `buyEventTicket` to purchase tickets.

4. **Champion Selection**
   - After the event duration, the manager can call `pickChampion` to select a winner.

## Requirements

- Solidity version: 0.8.26
- Requires the `ERC20` and `Vault` contracts to be imported.

## License

This project is licensed under the MIT License. See the LICENSE file for details.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request for any improvements or features.

---

Feel free to modify the README to better suit your project or add any additional sections you find necessary!
