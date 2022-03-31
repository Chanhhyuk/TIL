// User에 관한 내용으로 회원가입이나 로그인할 때 사용
import Foundation
import Firebase

// firebase에서 계정 정보를 가져올텐데 { [email: "apple@gmail.com"... ] } 이렇게 묶어서 가져오기 때문에 이것들을 쉽게 사용하게 하기 위해서 model링작업
struct User {
    let email: String
    let fullname: String
    let profileImageUrl: String
    let username: String
    let uid: String
    
    var isFollowed = false      // follow인지 아닌지 확인
    
    var isCurrentUser: Bool { // 현재 접속한 사용자인지 확인. 현재 사용자면 edit profile을 현재 사용자가 아니면 follow 버튼을 리턴하기 위함
        return Auth.auth().currentUser?.uid == uid
    }
    
    var stats: UserStats!       // 유저상태정보 post,follower,following 갯수
    
    // 이 방식말고 codeable프로토콜을 사용하는 방법이 이씀!
    init(dictionary: [String: Any]) {
        self.email = dictionary["email"] as? String ?? ""       // ?? default값, 값이 없을경우를 대비해서 "" 빈문자열로 설정
        self.fullname = dictionary["fullname"] as? String ?? "" // dictionary에서 key값 fullname을 찾는다 있으면 사용.
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.stats = UserStats(followers: 0, following: 0, posts: 0)
    }
}

// User 안에다가 만들면 될것을 굳이 바깥에다 만들었을까? 깔끔하게 하려고?
struct UserStats {
    let followers: Int
    let following: Int
    let posts: Int
}
