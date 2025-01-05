// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./interfaces/IOptimismMintableERC20.sol";

/**
 * @title OzL2Token
 * @notice ERC20 token designed for Layer 2 operations on Optimism.
 *         Allows the designated bridge to mint and burn tokens during cross-chain transactions.
 */
contract OzL2Token is ERC20, IOptimismMintableERC20 {
    /**
     * @dev Address of the L2 bridge authorized for minting and burning operations.
     */
    address private _l2Bridge;

    /**
     * @dev Address of the corresponding L1 token contract.
     */
    address private _l1Token;

    /**
     * @param bridgeAddress Address of the L2 bridge contract.
     * @param l1TokenAddress Address of the corresponding L1 token contract.
     * @param name_ Name of the ERC20 token.
     * @param symbol_ Symbol of the ERC20 token.
     */
    constructor(
        address bridgeAddress,
        address l1TokenAddress,
        string memory name_,
        string memory symbol_
    )
    ERC20(name_, symbol_)
    {
        _l2Bridge = bridgeAddress;
        _l1Token = l1TokenAddress;
    }

    /**
     * @notice Checks if the contract supports a specific interface.
     * @param interfaceId The interface identifier to query.
     * @return `true` if the contract supports the given interface, `false` otherwise.
     */
    function supportsInterface(bytes4 interfaceId) public pure override returns (bool) {
        return
            interfaceId == type(IOptimismMintableERC20).interfaceId ||
            interfaceId == type(IERC165).interfaceId;
    }

    /**
     * @notice Returns the address of the associated L1 token contract.
     * @return Address of the L1 token.
     */
    function remoteToken() external view override returns (address) {
        return _l1Token;
    }

    /**
     * @notice Returns the address of the L2 bridge authorized for minting and burning.
     * @return Address of the L2 bridge.
     */
    function bridge() external override returns (address) {
        return _l2Bridge;
    }

    /**
     * @notice Mints tokens to the specified recipient. Only callable by the L2 bridge.
     * @param recipient Address to receive the minted tokens.
     * @param amount Number of tokens to mint.
     */
    function mint(address recipient, uint256 amount) external override {
        require(msg.sender == _l2Bridge, "OzL2Token: Only the L2 bridge can mint tokens");
        _mint(recipient, amount);
    }

    /**
     * @notice Burns tokens from the specified account. Only callable by the L2 bridge.
     * @param account Address from which tokens will be burned.
     * @param amount Number of tokens to burn.
     */
    function burn(address account, uint256 amount) external override {
        require(msg.sender == _l2Bridge, "OzL2Token: Only the L2 bridge can burn tokens");
        _burn(account, amount);
    }
}