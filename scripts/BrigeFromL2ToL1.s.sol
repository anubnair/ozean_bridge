// scripts/DeployL1Token.s.sol
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/L1Token.sol";
import "../src/OzL2Token.sol";

interface InterfaceL2Token is IERC20 {
    function mint(address to, uint256 amount) external;
}

interface InterfaceBridge is IERC20 {
    function bridgeERC20(
        address fromToken, // here l2
        address toToken, // here l1
        uint256 amount,
        uint32 minGasLimit,
        bytes calldata data
    ) external;
}

contract BrigeFromL2ToL1 is Script {
    function run() external {
        uint256 deployerKey = vm.envUint("PRIVATE_KEY"); // Fetch private key from environment
        address l1TokenAddress = vm.envAddress("L1_TOKEN");
        address l2TokenAddress = vm.envAddress("L2_TOKEN");
        address l1BridgeAddress = vm.envAddress("L1_BRIDGE");
        address l2BridgeAddress = vm.envAddress("L2_BRIDGE");

        vm.startBroadcast(deployerKey);
        uint256 amount = 1 * 10**18;

        /****************************  BridgeFrom L1 to L2 ************************************/
        uint32 minGasLimit = 100000;
        InterfaceBridge(l2BridgeAddress).bridgeERC20(
            l2TokenAddress,
            l1TokenAddress,
            amount,
            minGasLimit,
            bytes("") // Add any extra data here
        );
        console.log("Bridge transaction from L2 to L1 is initiated");

        vm.stopBroadcast();
    }
}