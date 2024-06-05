// SPDX-License-Identifier: MIT
pragma solidity 0.8.24;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {IToken} from "./interface/IToken.sol";

contract DexstartToken is ERC20, Ownable, IToken {
  bool public isLaunched = false;

  constructor(
    string memory _name,
    string memory _symbol,
    uint256 _totalSupply,
    address _bondingCurve
  ) ERC20(_name, _symbol) Ownable(_bondingCurve) {
    _mint(_bondingCurve, _totalSupply);
  }

  function _update(address from, address to, uint256 value) internal override {
    require(isLaunched || from == owner() || to == owner(), "Tokens can only be transferred after DEX listing..!");
    super._update(from, to, value);
  }

  function launch() external override onlyOwner {
    isLaunched = true;
    _transferOwnership(address(0));
  }
}
