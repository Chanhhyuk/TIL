// 사용자 정보를 firebase에서 가져옴
import Firebase

struct UserService {
    static func fetchUser(completion: @escaping(User) -> Void ) {    // User 객체를 돌려주는 핸들러
        guard let uid = Auth.auth().currentUser?.uid else { return }    // firebase에서 현재 사용자 ID를 가져온다
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in // 해당 UID로 사용자 컬렉션으로 이동하여 해당 문서를 얻는다
            guard let dictionary = snapshot?.data() else { return }     // firebase에서 데이터를 가져온다
            let user = User(dictionary: dictionary)     // User클래스에서 만든 생성자 활용
            completion(user)

        }
    }
}
