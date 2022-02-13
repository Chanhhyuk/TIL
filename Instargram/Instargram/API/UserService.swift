// 사용자 정보를 가져옴
import Firebase

struct UserService {
    static func fetchUser(copletion: @escaping(User) -> Void ) {    // 작업이 완료되면 User값을 돌려준다
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { snapshot, ErrorCode in
            guard let dictionary = snapshot?.data() else { return }
            guard let email = dictionary["email"] as? String else { return }
            
            let user = User(email: <#T##String#>, fullname: <#T##String#>, profileImageUrl: <#T##String#>, username: <#T##String#>, uid: <#T##String#>)
        }
    }
}
