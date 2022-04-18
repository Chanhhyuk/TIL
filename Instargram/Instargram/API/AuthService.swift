import UIKit        // UIImage를 사용하므로 UIKit 사용
import Firebase
import AVFoundation

// 회원가입할때 전달할 데이터
struct AuthCredetials {     // viewModel은 var로 도배 했는데 여긴 let으로 선언했네?
    let email: String
    let password: String
    let fullname: String
    let username: String
    let profileImage: UIImage
}


// 회원가입의 데이터인 이메일 패스워드 이름과 프로필사진을 전송
struct AuthService {
    
    // private로 선언하면 다른곳에서 사용을 못했음
    // AuthDataResultCallback: 로그인 관련 이벤트가 완료될 때 호출됨
    static func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?){
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
        // 로그인 통신
    }
    
    // withCredential는 이 함수를 사용할 곳에서 쓰일 파라미터 이름 인자 레이블
    // AuthService 구조체를 함수 파라미터로 사용?
    // 이미지를 업로드하고 이미지url이 생성되는데 그것을 가져와서 사용자를 등록하는데 사용한다
    // 회원가입을 하게 되면 그 사용자에 대한 UID가 자동으로 생성된다. 그리고 이 UID는 그 사용자 정보를 데이터베이스에 저장할 때 DocumentID로 지정하여 통일성 및 유일성을 줘야한다.
    static func registerUser(withCredential credentials: AuthCredetials, completion: @escaping(Error?) -> Void){
        ImageUploader.uploadImage(image: credentials.profileImage) { imageUrl in
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                if let error = error {
                    print("Debug: \(error.localizedDescription)")
                    return
                }
                
                guard let uid = result?.user.uid else { return }        // uid 고유번호
                // UUID(Universally Unique Identifier): 고유의 값
                // NSUUID: 임의의 128비트 값을 생성해서 고유값을 만듬 (항상 값이 다르게 나온다)
                
                
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
