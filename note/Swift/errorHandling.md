# Error Handling(에러 처리)
- 컴파일오류(문법적 오류): 컴파일러가 코드가 잘못되었음을 알려줌
- 런타임오류: 다양한 이유로 실행되는 동안 발생. 앱이 꺼짐
- 앱이 그냥 꺼지는것보다 경고창을(네트워크를 다시 확인해주세요) 통해서 알려주면 사용자 편의성이 올라간다.

- 던질 에러는 열거형이기 때문에 사용하기전에 먼저 정의를 해주어야 한다.
- 에러를 정의하려면 Error 프로토콜을 사용해야 한다.

- do 블럭은 정상적인 경우 실행 catch 블럭은 함수가 에러를 던졌을 경우 실행
- 에러가 발생할 수 있는 함수를 실행할 때는 try를 앞에 붙인다. try는 do블럭안에서 실행해야 한다.
- try값이 return값이 있으면 다른 변수에 넣어서 사용하고, return 값이 없으면 그냥 사용한다.


## 에러 처리의 과정 (3단계)
```swift
// 1. 에러 정의 (어떤 에러가 발생할지 경우를 미리 정의)
enum WeightError: Error {
    case overWeight
    case underWeight
}

// 2. 에러가 발생할 수 있는 함수에 대한 정의
func checkingWeight(weight: Int) throws -> Bool {
    
    if weight > 500 {
        throw WeightError.overWeight
    } else if weight < 100 {
        throw WeightError.underWeight
    } else {
        if weight >= 200 {
            return true
        } else {
            return false
        }
    }
    
}

// 3. 에러가 발생할 수 있는 함수의 실행
do {
    let isChecked = try checkingWeight(weight: 250)
    print("사과의 무게는: \(isChecked)")

} catch {
    print("판매 불가 사과입니다.")
}
```

## 에러를 처리하는 방법 (try, try?, try!)
- try? 정상적인경우: 리턴타입으로 리턴, 에러가 발생하면: nil 리턴
- try? do catch를 사용하지 않아도 되고 try를 사용하려면 옵셔널 타입을 벗겨서 사용해야함
- try! 런타임에러가 발생하면 앱이 종료되므로 에러가 발생하지 않을거라고 확신할 경우에만 사용

```swift
// try
do {
    let isChecked = try checkingWeight(weight: 250)
    
    if isChecked {
        print("판매 가능한 사과입니다")
    } else {
        print("조금 자란 사과입니다.")
    }

} catch {
    print("판매 불가 사과입니다.")
}

// try?

let isChecked = try? checkingWeight(weight: 250)        // Bool?

if let result = isChecked {
    print(result)
}

// try!

let isChecked: Bool = try! checkingWeight(weight: 250)  // Bool

```
