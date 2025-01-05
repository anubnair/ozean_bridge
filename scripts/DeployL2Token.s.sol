// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "forge-std/Script.sol";
import "../src/OzL2Token.sol";

contract DeployL2Token is Script {
    function run() public {

        address l1Token = vm.envAddress("L1_TOKEN");   // Corresponding L1 token address
        address l2Bridge = vm.envAddress("L2_BRIDGE"); // L2 bridge address

        console.log("l1Token", l1Token);
        console.log("l2Bridge", l2Bridge);

        vm.startBroadcast();
        OzL2Token l2Token = new OzL2Token(
            l2Bridge,
            l1Token,
            "L2 Token",
            "L2T"
        );

        console.log("L2Token deployed at:", address(l2Token));

        vm.stopBroadcast();
    }
}