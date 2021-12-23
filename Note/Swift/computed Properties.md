# Computed Properties(계산속성)
- get과 set 영역으로 나뉜다.
- 값을 재계산 해야 하기 때문에 let 선언 불가
- get은 반드시 구현해야한다 set은 생략 가능 (get-only property, read-only property)

class Person {
    var birth: Int = 0
    
    var age: Int {
        get{
            return 2021 - birth
        }
        set(age) {
            self.birth = 2021 - age
        }
    }
}

var age:Int {
    return 2021 - birth 
}
// get만 사용시 get도 생략가능

var p1 = Person()
p1.birth = 1993
p1.age      // get 개발자가 값을 얻기 위해서
p1.age = 30 // 나이를 새로 입력 set 값을 셋팅하기 위해서


set은 파라미터를 설정하지 않으면 newValue로 사용할 수 있다.
