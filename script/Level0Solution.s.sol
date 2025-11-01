// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "../src/Level0.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract Level0Solution is Script {

    Level0 public level0 = Level0(0x660bEebfc7719a007E1541a58B35939C5f88c74e);

    function run() external {
        string memory password = level0.password();
        console.log("Password: ", password);
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        level0.authenticate(password);
        vm.stopBroadcast();
    }
}