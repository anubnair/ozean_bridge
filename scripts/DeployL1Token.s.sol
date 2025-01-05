// scripts/DeployL1Token.s.sol
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/L1Token.sol";

contract DeployL1Token is Script {
    function run() external {
        uint256 deployerKey = vm.envUint("PRIVATE_KEY"); // Fetch private key from environment
        vm.startBroadcast(deployerKey);

        // Deploy the L1 token with an initial supply
        L1Token token = new L1Token(1_000_000 * 10**18);

        console.log("L1 Token deployed to:", address(token));
        vm.stopBroadcast();
    }
}