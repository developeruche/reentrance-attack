//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

/// @author Casweeney Ojukwu (@codingcas)
contract Bank is ReentrancyGuard {

    /// @dev initializing Reentrancy Guard
    constructor() ReentrancyGuard() {}

    /// USing the imported address lib
    using Address for address payable;

    /// @dev mapping to track user's balance
    mapping(address => uint256) public balanceOf;

    /// @dev function to make deposit to this contract
    function deposit() external payable {
        balanceOf[msg.sender] += msg.value;
    }

    /// @dev this function logic can be re-entered but with the nonReentrant guard,
    /// it is protected
    function withdraw() nonReentrant() external {

        uint256 depositedAmount = balanceOf[msg.sender];

        payable(msg.sender).sendValue(depositedAmount);

        balanceOf[msg.sender] = 0;
    }

    /// @dev this function is returning the ether balance of the contract
    function getContractBalance() public view returns(uint ) {
      return address(this).balance;
    }
}