# Closures(클로저)
- 이름이 없는(익명) 함수
- 함수를 실행할때 전달하는 형태로 사용하기 때문에 굳이 이름이 필요없음
- 함수를 실행할때 파라미터로 전달하는 함수: Callback 함수
- 클로저는 아웃풋 생략가능 (컴파일러가 인풋으로 추론함)
- 함수는 타입이자 일급객체로 취급
1) 함수를 변수에 할당할 수 있음
2) 함수를 호출할때, 함수를 파라미터로 전달할 수 있음
3) 함수에서 함수를 반환할 수 있음

```swift
func add(a: Int, b: Int) -> Int {   // 함수
    let result = a + b
    return result
}

{ (a: Int, b: Int) in
    let result = a + b
    return result
}

{ (a,b) in
    let result = a + b
    return result
}
```

1) func를 지우고
2) 중괄호를 { 앞으로 뺀다
3) 중괄호를 뺀 자리에 in을 붙인다.

## 클로저 문법 최적화
- 간결한 코드 작성을 위해 축약된 형태의 문법을 제공
- 파라미터와 리턴타입을 Type Inference(타입 추론)
- 싱글 익스프레션인 경우(한줄), 리턴을 안 적어도 됨(Implicit Return)
- 아규먼트 이름을 축약(Shorthand Arguments) => $0, $1
- Trailling Closure문법: 함수의 마지막 전달 인자(argument)로 클로저 전달되는 경우ㅡ 소괄호 생략 가능

