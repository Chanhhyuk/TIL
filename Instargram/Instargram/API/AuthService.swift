// 회원가입뷰에서 받은 사용자 정보를 firebase에 전송할때 사용
import UIKit
import Firebase
import AVFoundation

// 회원가입할때 전달할 데이터
struct AuthCredetials {
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}


// 회원가입의 데이터인 이메일 패스워드 이름과 프로필사진을 전송
struct AuthService {
    
    // API struct에 static으로 function을 선언하는 이유는?
    // AuthDataResultCallback: 로그인 관련 이벤트가 완료될 때 호출됨
    static func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        // 로그인 통신
    }
    
    // withCredential 인자 레이블 credentials 매개변수?
    // AuthService 구조체를 함수 파라미터로 사용?
    // 이미지를 업로드하고 이미지url이 생성되는데 그것을 가져와서 사용자를 등록하는데 사용한다
    static func registerUser(withCredential credentials: AuthCredetials, completion: @escaping(Error?) -> Void){
        ImageUploader.uploadImage(image: credentials.profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                if let error = error {
                    print("Debug: \(error.localizedDescription)")
                    return
                }
                
                guard let uid = result?.user.uid else { return }        // uid 고유번호
                
                
                // imageUrl과 uid는 AuthCredetials에 없어서 만들어서 사용?
                
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
