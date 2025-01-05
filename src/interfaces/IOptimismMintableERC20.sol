// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/interfaces/IERC165.sol";

/**
 * @notice Interface for mintable and burnable tokens on Optimism Layer 2.
 *         Defines the necessary methods for L2 bridges to interact with tokens.
 */
interface IOptimismMintableERC20 is IERC165 {
    /**
     * @notice Returns the address of the associated L1 token contract.
     */
    function remoteToken() external view returns (address);

    /**
     * @notice Returns the address of the L2 bridge allowed to mint and burn tokens.
     */
    function bridge() external returns (address);

    /**
     * @notice Mints tokens to a specified address. Restricted to the L2 bridge.
     * @param recipient Address to receive the minted tokens.
     * @param amount Number of tokens to mint.
     */
    function mint(address recipient, uint256 amount) external;

    /**
     * @notice Burns tokens from a specified address. Restricted to the L2 bridge.
     * @param account Address from which tokens will be burned.
     * @param amount Number of tokens to burn.
     */
    function burn(address account, uint256 amount) external;
}

