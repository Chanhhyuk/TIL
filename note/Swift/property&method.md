# Property(속성) & Method(메서드)

## Stored Properties(저장속성)

## Lazy Stored Properties(지연 저장 속성)
- 인스턴스 초기화 할 때가 아닌 fruit() 접근하는 순간에 개별적으로 초기화가 되어 메모리를 사용하게 된다.
- 처음에 메모리공간이 없다가 생기기 때문에(변화) let으로는 선언 할 수 없다.
- 선언과 동시에 초기값을 꼭 설정해주어야 한다.
**메모리를 효율적으로 사용하기 위해 사용** 
**다른 속성에 의존 해야 할 때**

struct fruit {
    var color: String
    lazy var price: Int = 1000
    
    init(name: String){
        self.name = name
    }

}

var apple = fruit(color: "red")
color 라는 메모리 공간만 생기고, price 메모리 공간은 생기지 않는다.(지연저장)

apple.price // 이렇게 접근하는 순간 price 메모리 공간을 만든다.
