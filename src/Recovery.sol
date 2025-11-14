// 어떤 컨트랙트 개발자가 매우 간단한 토큰 팩토리 컨트랙트를 구축했습니다. 누구나 손 쉽게 새로운 토큰을 생성할 수 있고, 해당 개발자는 첫 번째 토큰 컨트랙트를 배포한 후 0.001이더를 전송하여 토큰을 추가로 얻었습니다. 하지만 지금은 그 컨트랙트의 주소를 잃어버렸습니다.
// 이 레벨의 목표는 잃어버린 그 컨트랙트 주소로부터 0.001 이더를 회수 (또는 제거)하는 것입니다.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Recovery {
    //generate tokens
    function generateToken(string memory _name, uint256 _initialSupply) public {
        new SimpleToken(_name, msg.sender, _initialSupply);
    }
}

contract SimpleToken {
    string public name;
    mapping(address => uint256) public balances;

    // constructor
    constructor(string memory _name, address _creator, uint256 _initialSupply) {
        name = _name;
        balances[_creator] = _initialSupply;
    }

    // collect ether in return for tokens
    receive() external payable {
        balances[msg.sender] = msg.value * 10;
    }

    // allow transfers of tokens
    function transfer(address _to, uint256 _amount) public {
        require(balances[msg.sender] >= _amount);
        balances[msg.sender] = balances[msg.sender] - _amount;
        balances[_to] = _amount;
    }

    // clean up after ourselves
    function destroy(address payable _to) public {
        selfdestruct(_to);
    }
}