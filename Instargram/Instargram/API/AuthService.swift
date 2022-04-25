import UIKit        // UIImage를 사용하므로 UIKit 사용
import Firebase


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
    // 얘는 왜 completion이 다를까 firebase만의 문법인가?
    static func logUserIn(withEmail email: String, password: String, completion: AuthDataResultCallback?){
        // completion 안 사용하니까 이 함수를 사용하려는 곳에 클로저를 사용 못하고 사용하면 Extra trailing closure passed in call 에러가 남
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    // withCredential는 이 함수를 사용할 곳에서 쓰일 파라미터 이름 인자 레이블
    // AuthService 구조체를 함수 파라미터로 사용?
    // 이미지를 업로드하고 이미지url이 생성되는데 그것을 가져와서 사용자를 등록하는데 사용한다
    // 회원가입을 하게 되면 그 사용자에 대한 UID가 자동으로 생성된다. 그리고 이 UID는 그 사용자 정보를 데이터베이스에 저장할 때 DocumentID로 지정하여 통일성 및 유일성을 줘야한다.
    // 왜 얘는 escaping에 Error을 주었을까?
    static func registerUser(withCredential credentials: AuthCredetials, completion: @escaping(Error?) -> Void){
        // 이미지 업로드를 먼저 하는 이유는 이미지를 storage에 업로드하고 그 url을 다시 다운 받은다음에 Database에 저장하기 위해
        ImageUploader.uploadImage(image: credentials.profileImage) { imageUrl in
            // ImageUploader에서 만든 completion을 imageUrl로 사용
            Auth.auth().createUser(withEmail: credentials.email, password: credentials.password) { (result, error) in
                if let error = error {
                    print("Debug: \(error.localizedDescription)")
                    return
                }
                
                
                // 생성된 계정의 uid를 얻는다
                // uid는 Firebase에서 자체적으로 생성하는건가?
                guard let uid = result?.user.uid else { return }        // uid 고유번호
                // UUID(Universally Unique Identifier): 고유의 값
                // NSUUID: 임의의 128비트 값을 생성해서 고유값을 만듬 (항상 값이 다르게 나온다)
                
                
                // imageUrl과 uid는 AuthCredetials에 없어서 만들어서 사용?
                let data: [String: Any] = ["email": credentials.email,
                                           "fullname": credentials.fullname,
                                           "profileImageUrl":imageUrl,
                                           "uid": uid,
                                           "username": credentials.username]
                // users 라는 collection을 만들고 uid로 된 document를 만든 다음 그 안에 key:value로 된 필드를 만든다
                COLLECTION_USERS.document(uid).setData(data, completion: completion)
            }
        }
        
    }
}
