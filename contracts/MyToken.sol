// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/extensions/ERC20Burnable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/v4.3.2/contracts/utils/math/SafeMath.sol";

contract MyToken is ERC20, ERC20Burnable {
    using SafeMath for uint256;
    address private immutable walletAddress;
    address private immutable contractOwner;

    constructor(string memory _name, string memory _symbol, address _walletAddress)
    ERC20(_name, _symbol) {
        _mint(msg.sender, 10 * 10 * 18);
        walletAddress = _walletAddress;
        contractOwner = msg.sender;
    }

    function withdrawEther(uint256 amount) external {
        require(msg.sender == contractOwner, "Only the contract owner can initiate a withdrawal");
        require(address(this).balance >= amount, "Insufficient contract balance");

        // Split into charity 
        uint256 charityAmount = amount.mul(10).div(100); // 10% of the amount
        uint256 projectAmount = amount.sub(charityAmount); // Remaining amount (90%)

        payable(walletAddress).transfer(charityAmount);
        payable(contractOwner).transfer(projectAmount);
    }
    // The Water Project

}