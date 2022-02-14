// 사용자 정보를 가져옴
import Firebase

struct UserService {
    static func fetchUser(completion: @escaping(User) -> Void ) {    // 작업이 완료되면 User값을 돌려준다
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in
            guard let dictionary = snapshot?.data() else { return }
            let user = User(dictionary: dictionary)
            completion(user)

        }
    }
}
