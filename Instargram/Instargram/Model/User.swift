import Foundation
// 사용자를 위한 모델 생성
// firebase에 설정되어있는 모든 속성값을 표현하기 위함
struct User {
    let email: String
    let fullname: String
    let profileImageUrl: String
    let username: String
    let uid: String
    
    // 초기화를 작성하여 스스로 처리할것
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""       // 값이 없을경우를 대비해서 "" 빈문자열로 설정
        self.fullname = dictionary["fullname"] as? String ?? "" // dictionary["키값"]
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""   // ?? default값
        self.username = dictionary["username"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
