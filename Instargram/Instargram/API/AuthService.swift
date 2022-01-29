import UIKit
import Firebase

struct AuthCredetials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

// 회원가입의 데이터인 이메일 패스워드 이름과 프로필사진을 전송
struct AuthService {
    static func registerUser(withCredential credentials: AuthCredetials){
        print("debug:\(credentials)")
    }
}
