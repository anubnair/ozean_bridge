// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "forge-std/Test.sol";
import "../src/L1Token.sol";
import "../src/OzL2Token.sol";

contract L1L2TokenBridgeTest is Test {
    L1Token private l1Token;
    OzL2Token private l2Token;

    address private l2Bridge = address(0x123);

    function setUp() public {
        // Deploy L1 token
        l1Token = new L1Token(1_000_000 * 10**18);

        // Deploy L2 token with a mock bridge
        l2Token = new OzL2Token(address(l2Bridge), address(l1Token), "L2 Token", "L2T");
    }

    function testMintOnL2() public {
        // Simulate L2 bridge minting tokens
        vm.prank(l2Bridge);
        l2Token.mint(address(this), 1000);

        assertEq(l2Token.balanceOf(address(this)), 1000, "Minting failed on L2");
    }

    function testBurnOnL2() public {
        // Simulate L2 bridge minting and then burning tokens
        vm.prank(l2Bridge);
        l2Token.mint(address(this), 1000);

        vm.prank(l2Bridge);
        l2Token.burn(address(this), 500);

        assertEq(l2Token.balanceOf(address(this)), 500, "Burning failed on L2");
    }
}