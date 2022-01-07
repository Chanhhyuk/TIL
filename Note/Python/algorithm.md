# Algorithm(Python)

자연수에 제곱근을 해서 딱 떨어지는 경우(1,4,9,16) 약수의 갯수 홀수
딱 떨이지지 않은 경우 약수의 갯수 짝수

```python
# 한번에 두개이상의 값 입력 받기
H,M = map(int, input().split())

# 여러줄 입력받기
# 반복문으로 여러줄을 입력 받아야 할 때는 input()으로 받는다면 시간초과가 발생할 수 있다
import sys
input = sys.stdin.readline().strip()

# 리스트로 입력 받기
score = list(map(int, input().split()))

# 구구단
N = input()
num = [1,2,3,4,5,6,7,8,9]

for i in num:
    print("%s * %s =" %(N,i),int(N) * i )
    
# 숫자의 제곱근
num = 9
num**0.5    # 3 

# 배열이 int형일때 문자형으로 한꺼번에 출력할 때
print(" ".join(map(str, result)))
```

## Swap (스와프)
- 특정한 리스트가 주어졌을 때 위치를 변경하는 작업.
```python
fruit = ["cherry","banana","apple"]
fruit[0],fruit[2] = fruit[2],fruit[0]
#['apple', 'banana', 'cherry']
```
- 대문자를 소문자로 소문자를 대문자로 변경
```python
a = "Apple"
a.swapcase()    # aPPLE
```

## 다중변환
```python
# 숫자를 곱한다 (*) 
# 숫자형으로는 각 자릿수별로 list에 넣을수 없으므로 문자열로 변환(str)
# 문자열로 변환한 각 자릿수 숫자를 list에 넣는다 (list,map)
# 다시 문자형을 숫자형으로 바꿔준다(int) 

A = int(input())
B = int(input())
C = int(input())
D = list(map(int, str(A * B * C)))
```

## 리스트 컴프리헨션
- 리스트를 초기화하는 방법 중 하나
- 대괄호[] 안에 조건문과 반복문을 넣는 방식으로 리스트를 초기화할 수 있다.
```python
# 홀수를 구하는 일반코드
array = []
for i in range(20):
    if i % 2 == 1:
        array.append(i)
print(array)

# 리스트 컴프리헨션을 사용한 코드
array = [i for i in range(20) if i % 2 == 1]
print(array)


# 특정 원소의 값만 없앨 때
a = [1,2,3,4,5,5,5]
remove_set = {3,5}

result = []
for i in a:
    if i not in remove_set:
        result.append(i)
print(result)           # [1,2,4]

# 리스트 컴프리헨션을 사용한 코드
a = [1,2,3,4,5,5,5]
remove_set = {3,5}

result = [i for i in a if i not in remove_set]
print(result)           # [1,2,4]
```

## remove_all이 없으니 대안으로 사용.
```python
a = [1,2,3,4,5,5,5]
remove_set = {3,5}
# remove_set에 포함되어 있지 않을 때만 result 리스트에 넣겠다는 의미
result = [i for i in a if i not in remove_set]
print(result)
```

## 문자열 역순으로 바꾸기
```swift
string[::-1]
```

## 라이브러리
- 표준 라이브러리: 특정한 프로그래밍 언어에서 자주 사용되는 표준 소스코드를 미리 구현해 놓은 라이브러리
- itertools: 파이썬에서 반복되는 형태의 데이터를 처리하는 기능을 제공하는 라이브러리. 순열과 조합 라이브러리를 제공한다.
- heapq: 힙 기능을 제공하는 라이브러리. 우선순위 큐 기능을 구현하기 위해 사용한다.
- bisect: 이진탐색 기능을 제공하는 라이브러리
- collections: 덱,카운터 등의 유용한 자료구조를 포함하고 있는 라이브러리
- math: 필수적인 수학적 기능을 제공

