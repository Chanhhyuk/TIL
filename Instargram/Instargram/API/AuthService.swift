import UIKit
import Firebase
import AVFoundation


struct AuthCredetials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}

// 회원가입의 데이터인 이메일 패스워드 이름과 프로필사진을 전송
struct AuthService {
    // AuthDataResultCallback: 로그인 관련 이벤트가 완료될 때 호출됨
    static func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        // 알맞는 이메일과 비번을 사용했는지 확인
    }
    
    // withCredential 인자 레이블 credentials 매개변수
    static func registerUser(withCredential credentials: AuthCredetials, completion: @escaping(Error?) -> Void){
        ImageUploader.uploadImage(image: credentials.profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                if let error = error {
                    print("Debug: \(error.localizedDescription)")
                    return
                }
                guard let uid = result?.user.uid else { return }        // uid는 위의 구조체에 없으니 따로 생성
                
                // data를 key:value 형식으로 전달
                let data: [String: Any] = ["email": credentials.email,
                                           "fullname": credentials.fullname,
                                           "profileImageUrl":imageUrl,
                                           "uid": uid,
                                           "username": credentials.username]
                // firebase 데이터베이스에 Colelction중 users 폴더에 있는 uid를 가지고 문서 생성
                COLLECTION_USERS.document(uid).setData(data, completion: completion)
            }
        }
        
    }
}
