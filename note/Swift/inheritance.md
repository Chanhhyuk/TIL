# Inheritance(상속)
- 클래스에만 있는 개념
- 성격이 비슷한 타입을 새로 만들어 1)저장속성을 추가하거나 2)메서드를 변형시켜서 사용하려는 것
- 상속하는 경우 : Parent Class, Super Class
- 상속받는 경우 : Child Class, Sub Class
- 어떤 class도 상속 하지 않은 class : Base Class
- 다중 상속은 지원하지 않는다.
- final 키워드는 상속불가
- 상위 클래스에 있는 멤버를 변형하는 것을 재정의라고 한다. / 재정의는 override 키워드를 붙여야 한다.

// Apple 클래스는 어떤 클래스도 상속하지 않는다 (Base Class)
class Apple { 
    var color = "red"
    var price = 1000
}

// final이 붙었으므로 상속 불가
final class banana { 
    final var color = "yellow" // 해당 멤버는 재정의 불가
    var price = 3000
}

// Apple에게 상속받으며(Child Class), Food를 상속한다(Parent Class)
class Fruit: Apple { // Apple class를 상속한다
    
    //var color = "red" 상속받았기 때문에 표기하지 않아도 값이 있다.
    //var price = 1000 
    var origin = "korea"
}

class Food: Fruit {
    var frash = 5.0
}

# Overriding(재정의)
- overloading(오버로딩) : 함수에서 하나의 이름에 여러 함수를 대응시켜서 사용
- overrriding(오버라이딩) : 클래스 상속에서 상위클래스의 속성/메서드를 재정의

- overrideing(재정의) 가능한 대상
1) 속성 (단, 저장 속성에 대한 재정의는 어떠한 경우에도 불가능) => 고유의 메모기 공간을 유지해야함
2) 메서드 (메서드, 서브스크립트, 생성자)

// 속성과 메서드는 재정의 방식이 다르다


class Apple {
    var price = 1000

    func color() {
        print("red")
    }
    
}

class Banana: Apple{
    override var price = 3000 // 저장속성의 재정의는 원칙적 불가
    
    
    // 저장속성 => (재정의) 계산속성은 가능. 메서드 형태로 구현하는것은 상위에 있는 메모리를 건들지 않기때문
    override var price: Int {
        get {
            return 2000
        }
        set {  // 읽기만 가능한 계산 속성으로 정의 불가능, 그래서 set도 꼭 같이 사용
            super.price = newValue // self로 사용하면 안됨
        }
    }
    
    super.color() // 상위클래스의 메서드를 호출 super
    
    override func color() { // 상속 받은 메서드를 변형해서 사용 override
        pritn("yellow")
    }
    
}

# 초기화의 과정과 생성자
- 여러개의 생성자가 있으면 개발자에게 여러 선택지를 줄 수 있다.

* 초기화의 방법

1) 저장 속성의 선언과 동시에 값을 저장

class Fruit {
    let apple: String = "red"
    let banana: Stirng = "yellow"
    let coconut: String = "brown"
}

// 저장 속성의 기본값을 설정하면 swift 컴파일러는 아래와 같이 init()을 자동으로 만들어 삽입해준다.

init() { // Default Initializer(기본 생성자)
    apple = "red"
    banana = "yellow"
    coconut = "brown"
}

2) 저장 속성을 옵셔널로 선언 (따로 init을 사용해 값 설정)

class Fruit {
    let apple: String
    let banana: Stirng
    let coconut: String
}

init() {
    apple = "red"
    banana = "yellow"
    coconut = "brown"
}

3) 생성자에서 값을 초기화


* 구조체는 Default Initializer(기본생성자), 더해서 Memberwise Initializer 까지 자동 생성

struct fruit {
    var apple: String
    var banana: String
    var coconut: String
}

**class보다 struct가 자주 사용되므로 더 편하게 사용하기 위해서 Memberwise Initializer 까지 자동생성**

