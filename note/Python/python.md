# Python 
- split, range
- and: &&, or: ||, not = !

## 입출력
input: 입력
print: 출력
sys.stdin.readline(): 많은 입력을 빨리 받기
rstrip(): readline()입력 후 엔터가 줄 바꿈 기호로 입력되는데 이 공백 문자를 제거하기 위함
```python
import sys
sys.stdin.readline().rstrip()


number1 = input("숫자를 입력하세요: ")
number2 = input("숫자를 입력하세요: ")

# 파이썬은 입력값을 문자열로 받으므로 숫자형으로 바꿔준다.
number1 = int(number1)
number2 = int(number2)
print("두 숫자를 더하면:",(number1 + number2))
```

## String
```python
# 문자 인덱싱 및 숫자형 변환
A = "357"
int(A[0])   # 3
int(A[1])   # 5
int(A[2])   # 7

# 문자 슬라이싱
A = "12345"
A[1:3]      #  2,3

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

## Tuple ()
- 한 번 선언된 값을 변경할 수 없다.
- List에 비해 상대적으로 공간 효율적이고 각 원소 성질이 서로 다를 때 주로 사용한다.
```python
()로 선언
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

# list 원소 하나 삽입
a.append(2)

# 오름차순으로 변경
a.sort()

# 내림차순으로 변경
a.sort(reverse = True)

# list 원소 뒤집기
a.reverse()

# 특정 인덱스에 데이터 추가
a.insert(2,3)   # 인덱스 2에 3추가

# 특정 값 개수 세기
a.count(3)      # 값이 3인 데이터 개수

# 특정 값 데이터 삭제
a.remove(1)     # 값이 1인 데이터 삭제 
```

## dict(사전자료형)
- Key와 Value의 쌍을 데이터로 가지는 자료형.
- 내부적으로 Hash Table을 이요하므로 기본적으로 데이터의 검색 및 수정에 있어서 O(1)의 시간에 처리할 수 있다.
```python
fruit = dict()
fruit['apple'] = 'red'
fruit['banana'] = 'yellow'
fruit['melon'] = 'green'

# 특정 원소가 있는지 검사
if 'apple' in fruit:
    print("'apple'를 키로 가지는 데이터가 존재합니다.")

# key값만 추출
fruit.keys()    # ['apple','banana','melon']

# value값만 추출    
fruit.values()  #['red','yellow','green']
```

## Set(집합 자료형)
- 중복을 허용하지 않는다. 순서가 없다.
- 특정 원소가 존재하는지를 검사하는 연산의 시간 복잡도는 사전 자료형과 마찬가지로 O(1)이다.
```python
a = set([1,1,2,3,4,4,5])
b = {1,1,2,3,4,4,5}

a | b   # 합집합
a & b   # 교집합
a - b   # 차집합
```

## 조건문
- 파이썬은 switch문이 없다.
- pass 키워드는 조건문에서 아무것도 처리하고 싶지 않을 때 사용한다.
- Conditional Expression(조건부 표현식)을 이용하면 한줄로 조건식을 사용할 수 있다.
- 다른 프로그래밍 언어와는 다르게 부등식을 0 < x < 20 이렇게 연달아 사용 가능
```python
score = 75
result = "Sucess" if score >= 80 else "Fail"
print(result)   #Fail 
```


## 반복문
- while문: 조건문이 참일 때에 한해서 반복수행
```python
for 변수 in 리스트(또는 튜플, 문자열),range(시작값,끝값):
    수행할 문장
```

## Function(함수)
- global 키워드: 함수 안에서 범위 밖에 변수를 사용하고 싶을 때 사용
```python
def 함수명(매개변수):
    실행할 소스코드
    return 반환 값
```
