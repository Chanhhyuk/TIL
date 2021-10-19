# ARC(Automatic Reference Counting)
- Reference Counting: 나의 메모리 주소를 가리키고 있는게 몇개인지 세는 것
- 값 형식은 종료되면 메모리에서 자동으로 제거가 되기 때문에 따로 관리를 할 필요가 없음
- Heap 영역에 할당되는 데이터를 관리를 해야지만 메모리에서 해제가 됨
- Heap은 비어있는 메모리를 찾아서 할당, Stack은 차곡차곡 쌓아서 할당
- 할당이 해제되지 않으면 Memory Leak(메모리 누수) 발생

|구분|값 형식|참조 형식|
|---|-----|-----|
|타입|Value Type|Reference Type|
|메모리 위치|메모리의 값이 복사되어 전달</br>값의저장: Stack|메모리의 주소를 전달</br>  값의 저장: Heap (주소를 Stack에 저장)|
|메모리 관리|값이 들어있는 스택의 스코프가 종료되면 메모리에서 자동 제거|RC(Reference Counting)을 통해 메모리를 관리|
|타입 예시|기본 타입(Int, String,...)</br> tuple,struct,enum,collection|class, closure|

1. Code(Program): 명령어 / 프로그램 / Read-only
2. Data: 전역변수 / 타입(static/class) 변수 / 공통으로 공유하기 위한 데이터 / 앱이 실행되는 동안 불변
3. Heap: 동적할당(일반적으로 긴시간 저장) / 크기가 크고, 관리할 필요가 있는 데이터 / 개발자가 잘 관리해야함
4. Stack: 함수실행을 위한 임시적 공간 / 크기가 작고 빠르게 사용하기 위한 데이터 / 알아서 자동 관리 됨

## MRC(수동RC관리), ARC(자동RC관리)
- Object-C의 경우 메모리를 수동 관리했음 (실수 가능성 높음)
- MRC: retain(RC 1증가), release(RC 1감소)
- ARC: 컴파일러가 메모리 관리코드를 자동으로 추가해 줌으로써 안정성 증가
1. 소유정책 - 인스턴스는 하나이상의 소유자가 있는 경우 메모리에 유지됨 (소유자 없으면 메모리에서 제거)
2. 참조카운팅 - 인스턴스(나)를 가르키는 소유자수를 카운팅

class fruit {
    var name: String
    var price: Int
    
    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }
}
var apple: Fruit? = Fruit(name:"apple", price: 1000)    // retain(apple)    RC:1
var a = apple       // retain(apple)        RC:2
a = nil         // release(apple)       RC:1
apple = nil     // release(apple)       RC: 0

## Strong Reference Cycle(강한 참조 사이클)

```swift
class Apple {
    var price: Int 
    var cook: ApplePie?         // 서로 참조
}

class ApplePie {
    var price: Int
    var ingredient : Apple?     // 서로 참조
}

var apple: Apple? = A
```
