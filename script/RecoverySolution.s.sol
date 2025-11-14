/*
잃어버린 주소 찾기 bash에서 이렇게 하면 됨
cast compute-address Recovery인스턴스주소 --nonce 1 

예시
cast compute-address 0x6A2310fF833342d02Ab133101b1396885A3A2A35 --nonce 1

그러면 이렇게 출력됨 이게 잃어버린 Recovery instnce address임
Computed Address: 0x8A8aBc7B1C3f9AE5E26a0e6C49B51291f068341c

그리고 이렇게 bash에 입력하면 문제 해결
cast send ComputedAddress "destroy(address payable)" $MY_ADDRESS --private-key $PRIVATE_KEY

예시
cast send 0x8A8aBc7B1C3f9AE5E26a0e6C49B51291f068341c "destroy(address payable)" $MY_ADDRESS --private-key $PRIVATE_KEY
*/


