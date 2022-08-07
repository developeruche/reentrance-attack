//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Address.sol";


contract Bank {
    /// USing the imported address lib
    using Address for address payable;

    /// @dev mapping to track user's balance
    mapping(address => uint256) public balanceOf;

    /// @dev function to make deposit to this contract
    function deposit() external payable {
        balanceOf[msg.sender] += msg.value;
    }

    /// @dev this function is not protected from reentracy attack
    function withdraw() external {
        uint256 depositedAmount = balanceOf[msg.sender];
        payable(msg.sender).sendValue(depositedAmount);
        balanceOf[msg.sender] = 0;
    }

    /// @dev this function is returning the ether balance of the contract
    function getContractBalance() public view returns(uint ) {
      return address(this).balance;
    }
}


// How to protect yourself from this kind of hack

// 1. Use @openzeppelin non-reentrancy guard contract 
// or
// 2. Make sure you do all you checks and update balances before making enternal calls