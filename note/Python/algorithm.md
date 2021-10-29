# Algorithm(Python)

```python
# 한번에 두개이상의 값 입력 받기
H,M = map(int, input().split())

# 구구단
N = input()
num = [1,2,3,4,5,6,7,8,9]

for i in num:
    print("%s * %s =" %(N,i),int(N) * i )
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

## 라이브러리
- 표준 라이브러리: 특정한 프로그래밍 언어에서 자주 사용되는 표준 소스코드를 미리 구현해 놓은 라이브러리
- itertools: 파이썬에서 반복되는 형태의 데이터를 처리하는 기능을 제공하는 라이브러리. 순열과 조합 라이브러리를 제공한다.
- heapq: 힙 기능을 제공하는 라이브러리. 우선순위 큐 기능을 구현하기 위해 사용한다.
- bisect: 이진탐색 기능을 제공하는 라이브러리
- collections: 덱,카운터 등의 유용한 자료구조를 포함하고 있는 라이브러리
- math: 필수적인 수학적 기능을 제공

