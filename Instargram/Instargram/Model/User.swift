import Foundation

struct User {
    let email: String
    let fullname: String
    let profileImageUrl: String
    let username: String
    let uid: String
    
    // 초기화를 작성하여 스스로 처리할것
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""       // 값이 없을경우를 대비해서 "" 빈문자열로 설정
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
