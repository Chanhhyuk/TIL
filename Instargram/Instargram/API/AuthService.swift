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
    static func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func registerUser(withCredential credentials: AuthCredetials, completion: @escaping(Error?) -> Void){
        ImageUploader.uploadImage(image: credentials.profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                if let error = error {
                    print("Debug: \(error.localizedDescription)")
                    return
                }
                guard let uid = result?.user.uid else { return }
                
                let data: [String: Any] = ["email": credentials.email,
                                           "fullname": credentials.fullname,
                                           "profileImageUrl":imageUrl,
                                           "uid": uid,
                                           "username": credentials.username]
                COLLECTION_USERS.document(uid).setData(data, completion: completion)
            }
        }
        
    }
}
