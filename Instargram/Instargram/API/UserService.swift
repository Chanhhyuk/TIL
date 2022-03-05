import Firebase
// user에 대한 정보를 가져온다 프로필을 보여줄 때 데이터로 쓰인다

typealias FirestoreCompletion = (Error?) -> Void

struct UserService {
    static func fetchUser(completion: @escaping(User) -> Void ) {    // Model 폴더에 User 클래스에서 만든 User 구조체 사용
        guard let uid = Auth.auth().currentUser?.uid else { return }    // firebase에서 현재 사용자 UID를 가져온다
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in // 해당 UID로 사용자 컬렉션으로 이동하여 해당 문서를 얻는다
            guard let dictionary = snapshot?.data() else { return }     // firebase에서 데이터를 가져온다
            let user = User(dictionary: dictionary)     // User클래스에서 만든 생성자 활용
            completion(user)
        }
    }
    
    
    // 친구 추천하는 탭에서 사용할 API 목록을 firebase에서 전부 가져온다
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            let users = snapshot.documents.map({ User(dictionary: $0.data()) })
            completion(users)
        }
    }
    
    static func followUser() {
        
    }
    static func unfollowUser(){
        
    }
    
}
