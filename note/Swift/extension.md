# Extensions(확장)
- Method(기능)을 추가하여 사용
- 추가 메모리 공간이 필요한 저장 속성을 확장하는 것은 불가
- 기존에 있는 기능에서(Int, Double, Stirng 등) 확장하여 사용 가능 (retroactive modeling)

Inheritance(상속)
1) 수직적
2) class만 가능
3) 성격이 비슷한 **타입을 새로 만들어** 데이터를 추가하고 method를 변형시켜 사용

Extension(확장)
1) 수평적
2) class/struct/enum
3) **현재 존재하는 타입**에 method를 추가하여 사용 


```
class Apple{ // 기존 타입
    
}

var a = Apple()
a.appleEat() 
// 확장이 정의되기 전에 생성되었지만, 기존 타입 안에 확장이 들어가므로 기존타입이 먼저 정의되어있다면 사용이 가능하다. 


extension Apple { // 확장

    var banana = "yellow" // 불가
 
    func appleEat() { // 새로운 기능 추가
        print("eat")
    }
    
}

```


