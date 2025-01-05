// contracts/MyToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract L1Token is ERC20 {
    constructor(uint256 initialSupply) ERC20("L1 Token", "L1T") {
        _mint(msg.sender, initialSupply);
    }
}