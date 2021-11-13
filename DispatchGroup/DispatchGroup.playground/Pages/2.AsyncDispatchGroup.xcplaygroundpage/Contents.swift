//: [Previous](@previous)
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true



// 천천히 더하는 함수의 정의 (내부는 동기적인 작업)
func slowAdd(_ input: (Int, Int)) -> Int {
    sleep(2)
    return input.0 + input.1
}


// 위의 천천히 더하는 함수를 ==> 비동기적인 함수로 변형 ⭐️
func asyncSlowAdd(_ input: (Int, Int), completion: @escaping (Int) -> ()) {
    DispatchQueue.global(qos: .utility).async {
        let result = slowAdd(input)
        completion(result)
    }
}



//: # 디스패치 그룹
//: ### 그룹지어진 비동기 작업들이 어느시점에 모두 완료하는 지가 관심
//: ### (2) 비동기처리 내에서, 비동기적인 함수도 존재하는 경우

let numberArray = [(0,1), (2,3), (4,5), (6,7), (8,9), (10,11)]



// 디스패치 그룹 생성
let group2 = DispatchGroup()


// 반복문으로 비동기 그룹함수 활용하기
for pair in numberArray {
    DispatchQueue.global(qos: .utility).async(group: group2) {
        //group2.enter()
        asyncSlowAdd(pair) { (result) in
            print("결과값 출력 = \(result)")
            //group2.leave()
        }
    }
    
}


let defaultQueue = DispatchQueue.global()



// 모든 비동기 작업이 끝남을 알림받기
group2.notify(queue: defaultQueue) {
    print("====모든 작업이 완료 되었습니다.====")
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
