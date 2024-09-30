// SPDX-License-Identifier: MIT

pragma solidity 0.8.22;

import "./IERC20.sol";





contract Bank {
    IERC20 public immutable token;
    uint public shares;
  
    address public _owner;

    uint public totalSupply;
    uint public totalShares;
    uint interestTime;

    mapping(address => uint) storedTokens;
    mapping(address => uint) public balanceOf;

    constructor(address _token) {
        token = IERC20(_token); 
        totalSupply = token.totalSupply();
        interestTime = block.timestamp + (1 minutes);
    }


    //to deposit tokens in the bank vault
    function depositTokens(address _depositor,uint amount)external{
        storedTokens[_depositor] = amount;
    }


    // to withdraw tokens from the bank vault.

    function withdrawTokens(address _withdrawal) external returns(uint){

        uint amount = storedTokens[_withdrawal];
        storedTokens[_withdrawal] = 0;
        return  amount;
    }

    function bankBalance(address _customer) external view returns(uint){
        return storedTokens[_customer];
    }
    

   function transferFunc(address owner,address _recepient,uint _amount) public{
    token.transferFunc(owner,_recepient,_amount);
   }

    function _mint(address _to, uint _shares) internal {
        totalShares += _shares;
        balanceOf[_to] += _shares;
    }

    function _burn(address _from, uint _shares) internal {
        totalShares -= _shares;
        balanceOf[_from] -= _shares;
}