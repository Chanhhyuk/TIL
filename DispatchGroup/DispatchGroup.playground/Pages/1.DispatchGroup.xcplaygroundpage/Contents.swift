//: [Previous](@previous)
import UIKit
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true



// 천천히 더하는 함수의 정의 (내부는 동기적인 작업)
func slowAdd(_ input: (Int, Int)) -> Int {
    sleep(2)
    return input.0 + input.1
}




//: # 디스패치 그룹
//: ### 그룹지어진 비동기 작업들이 어느시점에 모두 완료하는 지가 관심
//: ### (1) 비동기처리 내에서 동기적인 함수만 사용할 경우

let numberArray = [(0,1), (2,3), (4,5), (6,7), (8,9), (10,11)]


//: 1) "디스패치 그룹" 생성하기
// 디스패치 그룹 생성
let group1 = DispatchGroup()        // 디폴트 이니셜라이져로 "디스패치그룹" 생성하기


//: 2) 작업들을 비동기적으로 보낼때 "그룹 꼬리표" 붙이기
for inValue in numberArray {
    // 위에서 생성한 디스패치 그룹을 아규먼트에 넣기
    DispatchQueue.global(qos: .utility).async(group: group1) {
        // 내부엔 동기적인 함수만 존재 ⭐️
        let result = slowAdd(inValue)
        print("결과값 출력 = \(result)")
        
        
    }
}


//: 3) 그룹의 모든 작업이 완료했을때 알림(notify) 받기
let defaultQueue = DispatchQueue.global()

// 그룹의 notify. 작업이 완료하고 어떤 일을 할 것인지 정하기
group1.notify(queue: defaultQueue) {
    print("====그룹1 안의 모든 작업이 완료====")
    PlaygroundPage.current.finishExecution()
}




//: [Next](@next)
//Copyright (c) 2021 we.love.code.allen@gmail.com
//
//Permission is hereby granted, free of charge, to any person obtaining a copy
//of this software and associated documentation files (the "Software"), to deal
//in the Software without restriction, including without limitation the rights
//to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//copies of the Software, and to permit persons to whom the Software is
//furnished to do so, subject to the following conditions:
//
//The above copyright notice and this permission notice shall be included in
//all copies or substantial portions of the Software.
//
//Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
//distribute, sublicense, create a derivative work, and/or sell copies of the
//Software in any work that is designed, intended, or marketed for pedagogical or
//instructional purposes related to programming, coding, application development,
//or information technology.  Permission for such use, copying, modification,
//merger, publication, distribution, sublicensing, creation of derivative works,
//or sale is expressly withheld.
//
//THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//THE SOFTWARE.
