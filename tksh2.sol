// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/acces/Ownable.sol";

contract KESStablecoin is ERC20, Ownable {
	// Mapping to track frozen accounts
	mapping(address =>bool) private _frozenAccounts;

	// Constructor to set the token name and symbol
	constructor() ERC20("Kenyan Shilling Stablecoin", "KES") {}

	function mint(address to, uint256 amount) public onlyOwner {
		_mint(to, amount);
	}
	function burn(address from, uint256 amount) public onlyOwner {
		_burn(from, amount);
	}

	function transfer(address recipient, uint256 amount) public override returns (bool) {
		require(!_frozenAccounts[_msgSender()], "Account is frozen");
		_transfer(_msgSender(), recipient, amount);
		return true;
	}
	
	function balanceOf(address account) public view override returns (uint256) {
		return super.balanceOf(account);
	}

	function auditAccount(address account) public view onlyOwner returns (uint256) {
		return balanceOf(account);
	}
	// Audit function to get total circulating supply
	function totalSupplyAudit() public view onlyOwner returns (uint) {
		return totalSupply();
	}

	// Freeze an account
	function freezeAccount(address account) public onlyOwner {
		_frozenAccounts[account] = true;
	}
	// Unfreeze
	function unfreezeAccount(address account) public onlyOwner {
		_frozenAccounts[account] = false;
	}
	function isFrozen(address account) public view returns (bool) {
		return _frozenAccounts[account];
	}
}
