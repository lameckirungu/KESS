// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

// Import the ERC20 standard from OpenZeppelin for reusable fuctionality
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

/* Define the contract and inherit from ERC20 and Ownable for access control
 * A Constructor to set the token name and symbol when deploying the contract follows
 */
contract KESStablecoin is ERC20, Ownable {
	constructor() ERC20("Kenyan Shilling Stablecoin", "KES") {}

	// Mint function restricted to the owner
	function mint(address to, uint256 amount) public onlyOwner {
		_mint(to, amount);
	}
	// Burn function to destroy tokens after KES withdrawal
	function burn(address from, uint256 amount) public onlyOwner {
		_burn(from, amount);
	}
	// Transfer functions to facilitate transfers between users
	function transfer(address recipient, uint256 amount) public override returns (bool) {
		_transfer(_msgSender(), recipient, amount);
		return true;
	}

}

