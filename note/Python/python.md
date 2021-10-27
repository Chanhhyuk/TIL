# Python

## 입출력
input: 입력
print: 출력
```python
number1 = input("숫자를 입력하세요: ")
number2 = input("숫자를 입력하세요: ")

// 파이썬은 입력값을 문자열로 받으므로 숫자형으로 바꿔준다.
number1 = int(number1)
number2 = int(number2)
print("두 숫자를 더하면:",(number1 + number2))
```

## split

파이썬은 switch문이 없다.

```python
A = "357"
int(A[0])   // 3
int(A[1])   // 5
int(A[2])   // 7

and // &&
or  // ||
```

## Number
```python
a = 1000;       # 정수형
b = 5.          # 실수형 소수부 0일때 생략가능
c = -.7         # 정수부 0일때 생략가능

d = 10.5
round(d)        # 반올림    # 11
e = 10.3456
round(e,2)      # 자릿수 반올림   # 10.35


a = 7
b = 3

# 거듭제곱
a ** b      # 343

# 나누기
a / b       # 2.3333335

# 나머지
a % b       # 1

# 몫
a // b      # 2
```

## List
```python
# 배열 선언
a = [1,2,3,4,5]

# 배열 접근
a[0]
            
# 빈 배열 선언
a = list()      a = []

# 원소값 변경
a[0] = 0

# index 뒤로 접근
a[-1]       // 5

# 
```
