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
# 홀수를 구하는 일반ㅅ코드
array = []
for i in range(20):
    if i % 2 == 1:
        array.append(i)
print(array)

# 리스트 컴프리헨션을 사용한 코드
array = [i for i in range(20) if i % 2 == 1]
print(array)
```

## remove_all이 없으니 대안으로 사용.
```python
a = [1,2,3,4,5,5,5]
remove_set = {3,5}
# remove_set에 포함되어 있지 않을 때만 result 리스트에 넣겠다는 의미
result = [i for i in a if i not in remove_set]
print(result)
```
