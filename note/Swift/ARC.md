## Memory Struct(메모리 구조)
1. Code(Program)
명령어 / 프로그램 / Read-only / 앱이 끝날때까지 지워지지 않는다.
그래서 당연히 앱이 끝날때까지 필요한것만 넣어야한다 **(그렇지 않으면 메모리 낭비가 일어난다.)**

2. Data
전역변수 / 타입(static/class) 변수 / 공통으로 공유하기 위한 데이터 / 앱이 실행되는 동안 불변

3. Heap
동적할당(일반적으로 긴시간 저장) / 크기가 크고, 관리할 필요가 있는 데이터
비어있는 메모리를 찾아서 저장 / 스택보다 조금 더 오래 저장하기 위해 클래스나 객체를 저장
Heap 영역에 할당되는 데이터를 관리를 해야만 메모리가 해제가 된다.(개발자가 잘 관리해야함)
할당이 해제되지 않으면 **Memory Leak(메모리 누수)** 발생

4. Stack
함수실행을 위한 임시적 공간 / 크기가 작고 빠르게 사용하기 위한 데이터 / 알아서 자동 관리 됨 / 차곡차곡 쌓아서 저장



# ARC(Automatic Reference Counting)
- 값 형식은 종료되면 메모리에서 자동으로 제거가 되기 때문에 따로 관리를 할 필요가 없음
- Heap 영역 할당이 해제되지 않으면 Memory Leak(메모리 누수) 발생
- Reference Counting: 나의 메모리 주소를 가리키고 있는게 몇개인지 세는 것
- 전적으로 메모리관리를 자동으로 해준다기보다는 카운팅을(숫자세는것) 자동으로 해주는 것

|구분|값 형식|참조 형식|
|---|-----|-----|
|타입|Value Type|Reference Type|
|메모리 위치|메모리의 값이 복사되어 전달</br>값의저장: Stack|메모리의 주소를 전달</br>  값의 저장: Heap (주소를 Stack에 저장)|
|메모리 관리|값이 들어있는 스택의 스코프가 종료되면 메모리에서 자동 제거|RC(Reference Counting)을 통해 메모리를 관리|
|타입 예시|기본 타입(Int, String,...)</br> tuple,struct,enum,collection|class, closure|

## MRC(수동RC관리), ARC(자동RC관리)
- 인스턴스를 사용해야 되는데 메모리에서 해제시켜버린다면???
1) 인스턴스의 프로퍼티와 함수에 접근 불가
2) 강제로 접근한다면 앱이 죽음
- Object-C의 경우 메모리를 수동 관리했음 (실수 가능성 높음)
- MRC: retain(RC 1증가), release(RC 1감소)
- ARC: 컴파일러가 메모리 관리코드를 자동으로 추가해 줌으로써 안정성 증가
- ARC는 자동으로 retain, release를 삽입해서 retainCount를 관리하고 0이 될때 deinit을 호출해서 인스턴스를 메모리 해제를 시킨다.
- 자동으로 삽입된 코드는 complie time(build할 때)에 실행 (runtime에 계속 실행되는게 아님)
1. 소유정책 - 인스턴스는 하나이상의 소유자가 있는 경우 메모리에 유지됨 (소유자 없으면 메모리에서 제거)
2. 참조카운팅 - 인스턴스(나)를 가르키는 소유자수를 카운팅
```swift
class Fruit {       // Heap의 영역에 인스턴스가 하나 생긴다.
    var name: String
    var price: Int
    
    init(name: String, price: Int) {     // 생성자
        self.name = name
        self.price = price
    }
    
    deinit {        // 소멸자: 실제로 해제되는지 확인
        print("\(name) 메모리 해제")
    }
    
}
// stack의 apple과 banana가 변수가 동일한 fruit(Heap)을 가리킨다.
// apple과 banana 즉 2개가 가르키고 있기때문에 RC는 2개가 된다.
var apple: Fruit? = Fruit(name:"apple", price: 1000)    // retain(apple)    RC:1
var banana: Fruit? = Fruit(name:"banana", price: 4000)  // retain(banana)    RC:2
apple = nil     // release(apple)       RC:1
banana = nil    // release(banana)      RC:0
```


## Strong Reference Cycle(강한 참조 사이클)

```swift
class Fruit {
    var name: String
    weak var cook: Food?
    
    init(name: String){
        self.name = name
    }
    deinit {            // 해제되는지 확인을 위한 소멸자
        print("\(name) 메모리 해제")
    }
}

class Food {
    var name: String
    weak var ingredient : Fruit?
    
    init(name: String){
        self.name = name
    }
    deinit {            // 해제되는지 확인을 위한 소멸자
        print("\(name) 메모리 해제")
    }
}
var apple: Fruit? = Fruit(name: "사과")
var applePie: Food? = Food(name: "사과파이")

apple?.cook = applePie           // 서로 참조
applePie?.ingredient = apple     // 서로 참조

apple = nil     // 객체가 서로를 참조하는 강한 참조 사이클로 인해변수의 참조에 nil을 할당해도 메모리 해제가 되지 않는
applePie = nil  // 메모리 누수(Memory Leak)의 상황이 발생     

apple?.cook = nil               // RC를 고려하여, 참조 해제 순서를 주의해서 코드를 작성
applePie?.ingredient = nil      // 이것까지 해야 메모리 해제가 됨, 위에 코드보다 먼저 적어줘야 한다.

```

## Memory Leak 해결방법
- Weak Reference(약한참조): 참조하고 있던 인스턴스가 사라지면, nil로 초기화 됨 / let 선언 불가 / non-Optional 선언불가
- Unowned Reference(비소유참조): 참조하고 있던 인스턴스가 사라지면 nil로 초기화 되지 않음(에러)
- Unowned가 이론상 빠르지만 한번 더 고려할것이 있기때문에 주로 Weak를 사용한다.

||Weak Reference</br>(약한 참조)|Unowned Reference</br>(비소유 참조)|
|---|-----|-----|
|예시|weak var </br>(nil 자동할당)|unowned var </br>(nil 자동할당하지 않음)|
|공통점|가르키는 인스턴스의 RC의 숫자를 올라가지 않게 함(인스턴스 사이의 강한 참조를 제거)</br>변수를 통해 인스턴스에 접근 가능하지만, 인스턴스를 유지시키는 것은 불가능|
|차이점|소유자에 비해, 보다 짧은 생명주기를 가진 인스턴스를 참조할때 주로 사용</br>|소유자 보다 인스턴스의 생명주기가 더 길거나 같은 경우에 사용|

```swift
class Fruit {
    var name: String
    weak var cook: Food?        // unowned 사용할 때는 weak 자리에 넣어주면 된다.
    
    init(name: String){
        self.name = name
    }
    deinit {
        print("\(name) 메모리 해제")
    }
}

class Food {
    var name: String
    weak var ingredient : Fruit?
    
    init(name: String){
        self.name = name
    }
    deinit {
        print("\(name) 메모리 해제")
    }
}

var apple: Fruit? = Fruit(name: "사과")
var applePie: Food? = Food(name: "사과파이")

apple?.cook = applePie           // 서로 참조
applePie?.ingredient = apple     // 서로 참조

apple = nil         // 메모리 해제 
applePie = nil      // 메모리 해제
```

## Closure memory
- 캡쳐현상: 클로저는 사용이 필요 없어질때까지 Heap 영역에 존재해야하고, 클로저 내부에서 외부에 존재하는 변수를 계속 사용해야 하기때문에 캡쳐 현상이 발생
- 캡처리스트 사용이유: 1) 값 타입은 값
