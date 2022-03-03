import Foundation

// firebase에서 계정 정보를 가져올텐데 { [email: "apple@gmail.com"... ] } 이렇게 묶어서 가져오기 때문에 이것들을 쉽게 사용하게 하기 위해서 model링작업
struct User {
    let email: String
    let fullname: String
    let profileImageUrl: String
    let username: String
    let uid: String
    
    // 이 방식말고 codeable프로토콜을 사용하는 방법이 이씀!
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""       // ?? default값, 값이 없을경우를 대비해서 "" 빈문자열로 설정
        self.fullname = dictionary["fullname"] as? String ?? "" // dictionary에서 key값 fullname을 찾는다 있으면 사용.
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
