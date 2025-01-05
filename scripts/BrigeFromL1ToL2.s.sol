// scripts/DeployL1Token.s.sol
pragma solidity ^0.8.0;

import "forge-std/Script.sol";
import "../src/L1Token.sol";

interface InterfaceL1Token is IERC20 {
    function mint(address to, uint256 amount) external;
}

interface InterfaceBridge is IERC20 {
    function bridgeERC20(
        address l1Token,
        address l2Token,
        uint256 amount,
        uint32 minGasLimit,
        bytes calldata data
    ) external;
}

contract BrigeFromL1ToL2 is Script {
    function run() external {
        uint256 deployerKey = vm.envUint("PRIVATE_KEY"); // Fetch private key from environment
        address l1TokenAddress = vm.envAddress("L1_TOKEN");
        address l2TokenAddress = vm.envAddress("L2_TOKEN");
        address l1BridgeAddress = vm.envAddress("L1_BRIDGE");
        address l2BridgeAddress = vm.envAddress("L2_BRIDGE");

        vm.startBroadcast(deployerKey);
        /****************************  MINT L1 ************************************/
        // Mint L1 token (this can be removed, as it is preminted
        uint256 amount = 1 * 10**18;
//        InterfaceL1Token(l1TokenAddress).mint(msg.sender, amount);
//        console.log("L1 Token minted:");

        /****************************  approve bridge to spend L1 token ************************************/
        IERC20(l1TokenAddress).approve(l1BridgeAddress, amount);
        console.log("Approve transaction successful");


        /****************************  BridgeFrom L1 to L2 ************************************/
        uint32 minGasLimit = 100000;
        InterfaceBridge(l1BridgeAddress).bridgeERC20(
            l1TokenAddress,
            l2TokenAddress,
            amount,
            minGasLimit,
            bytes("") // Add any extra data here
        );
        console.log("Bridge transaction from L1 successful");

        vm.stopBroadcast();
    }
}