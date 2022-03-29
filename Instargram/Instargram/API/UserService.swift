import Firebase
typealias FirestoreCompletion = (Error?) -> Void // 사용하기 더 쉽도록 새로운 유형의 이름을 만듬

struct UserService {
    
    // MainController에서 사용
    static func fetchUser(completion: @escaping(User) -> Void ) {    // Model 폴더에 User 클래스에서 만든 User 구조체 사용
        guard let uid = Auth.auth().currentUser?.uid else { return }    // firebase에서 현재 사용자(로그인된) UID를 가져온다
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in // 해당 UID로 사용자 컬렉션으로 이동하여 해당 문서를 얻는다
            guard let dictionary = snapshot?.data() else { return }     // firebase에서 데이터를 가져온다
            let user = User(dictionary: dictionary)     // Model User파일에 User구조체에서 만든 생성자 활용
            completion(user)
        }
    }
    
    
    // SearchController에서 사용
    // 친구 추천하는 탭에서 사용할거기 때문에 firebase에서 user를 전부 가져온다
    static func fetchUsers(completion: @escaping([User]) -> Void) {
        COLLECTION_USERS.getDocuments { (snapshot, error) in
            guard let snapshot = snapshot else { return }
            let users = snapshot.documents.map({ User(dictionary: $0.data()) }) // option 누른 후 users를 클릭해보면 알 수 있다 let users = [User] 라는걸
            completion(users)
        }
    }
    
    static func followUser(uid: String, completion: @escaping(FirestoreCompletion)){
        guard let currentUid = Auth.auth().currentUser?.uid else { return }     // 현재 사용자
        // following 문서에 현재 사용자의 이름으로
        // completion을 사용하지 않고 실행?
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).setData([:]) { error in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).setData([:], completion: completion)
        }
    }
    
    // API를 올바르게 찾아가서 삭제만 해주면 됨
    static func unfollowUser(uid: String, completion: @escaping(FirestoreCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }     // 현재 사용자
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).delete { error in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).delete(completion: completion)
        }
    }
    
    // 프로세스가 백엔드에서 완료될 때마다 UI가 업데이트 된다
    static func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).getDocument { (snapshot, error) in
            guard let isFollowed = snapshot?.exists else { return }
            completion(isFollowed)
        }
    }
    
    static func fetchUserStats(uid: String, completion: @escaping(UserStats) -> Void) {
        COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { (snapshot, _) in
            let followers = snapshot?.documents.count ?? 0
            COLLECTION_FOLLOWING.document(uid).collection("user-following").getDocuments { (snapshot, _) in
                let following = snapshot?.documents.count ?? 0
                
                COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid).getDocuments { (snapshot, _) in
                    let posts = snapshot?.documents.count ?? 0
                    completion(UserStats(followers: followers, following: following, posts: posts))
                }
                
            }
        }
    }
    
}
