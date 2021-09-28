# Variable(변수)
data(자료)를 담을 수 있는 공간
1. 식별자(변수의 이름)은 **한 영역**에서 유일한 하나의 이름만 사용해야 한다.
2. 숫자로 첫글자로 시작하는 것 금지

## String Interpolation(문자열 보간법)
\(변수명)

# Constants(상수)
변하지 않는 data(자료)를 담을 수 있는 공간

# Data Type
데이터를 메모리공간에 어떤 크기, 어떤 형태로 저장할 것인지를 정한다.

## 종류
Int(정수)
Float(실수), Double(실수) // 정밀도 차이
Character(문자), String(문자열)
Bool(true,false)

## 선언과 저장
변수의 초기화 = 변수를 **선언**한 후 처음으로 어떠한 값을 **저장**하는 것
// 변수를 선언과 동시에 저장
var num = 10 // Type Inference (타입 추론)
var num: Int = 10 // Type Annotation (타입 명시)

## Conversion(타입변환)
"123" -> Int("123") -> 123 // 타입 변환
"apple" -> Int("apple") -> nil // 변환되지 않음
123.45 -> Int(123.45) -> 123 // 데이터 일부 유실

## Type Alias(타입치환)
typealias Name = target
// target이 Name이라는 단어로 치환된다.
// 시스템적으로 기존에 정해져있는 명령어를 내가 임의로 커스텀 할 수 있다.



