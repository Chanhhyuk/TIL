# TypeCasting(타입변환)
is 연산자 - 타입에 대한 검사를 수행하는 연산자 (type check operator)

class Apple {
    color : "red"
    price : 1000
}

class Fruit: Apple{
    var region: "korea"
}

let apples = Apple()

let fruits = Fruit()


apples is Apple = true
apples is Fruit = false

fruits is Apple = true
fruits is Fruit = true
