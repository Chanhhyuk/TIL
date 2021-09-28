# Conditional Statements(조건문)
조건에 따라서 어떤 동작을 할지 말지를 정함.

## if
모든 조건에서 사용할 수 있고 모든 switch문을 if로 변경 할 수 있다.

if true와 false가 결과로 나오는 조건 문장(,로 여러개 연결 가능) {
    
    // 조건 문장에서 true가 나올 시 실행될 코드

} else if { //그 다음 조건문으로 계속 만들어서 다른 조건문을 넣어 사용 가능  

} else { // if와 else if문들에 아무것도 해당 되지 않을 시 else문 실행

}

## switch
if문보다 가독성이 좋으나 한정적으로 사용가능. 분기처리에 많이 사용한다.

switch 변수(비교할 값) {
    case 값1: // 변수에서 나올 수 있는 값들 중 하나
        code // 값1이 해당될 때에 실행될 code
    case 값2,값3: // **,로 값 여러개 설정 가능**
        code
        fallthrough // **fallthrough 바로 뒤에 문장을 조건 상관없이 무조건 실행(값4 실행)**
    case 값4
    case let a where a % 2 == 0: // switch 변수(비교할 값)을 상수 a에 바인딩한 후 where 조건절을 만들 수 있다.
    default: // 명시한 조건에 포함되지 않을 모든 상황에서 실행될 문장
        break // 실행하려는 코드가 없을 때, break 키워드를 반드시 입력!
}


