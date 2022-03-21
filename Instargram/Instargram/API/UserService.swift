import Firebase
// user에 대한 정보를 만듬 프로필을 보여줄 때 데이터로 쓰인다

typealias FirestoreCompletion = (Error?) -> Void
// 사용하기 더 쉽도록 새로운 유형의 이름을 만듬

struct UserService {
    
    // 로그인한 계정의 프로필을 보여줄거기 때문에 하나의 User 내용만 있으면 된다
    static func fetchUser(completion: @escaping(User) -> Void ) {    // Model 폴더에 User 클래스에서 만든 User 구조체 사용
        guard let uid = Auth.auth().currentUser?.uid else { return }    // firebase에서 현재 사용자(로그인된) UID를 가져온다
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in // 해당 UID로 사용자 컬렉션으로 이동하여 해당 문서를 얻는다
            guard let dictionary = snapshot?.data() else { return }     // firebase에서 데이터를 가져온다
            let user = User(dictionary: dictionary)     // Model User파일에 User구조체에서 만든 생성자 활용
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
    
    static func followUser(uid: String, completion: @escaping(FirestoreCompletion)){
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).setData([:]) { error in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).setData([:], completion: completion)
        }
    }
    
    // API를 올바르게 찾아가서 삭제만 해주면 됨
    static func unfollowUser(uid: String, completion: @escaping(FirestoreCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).delete { error in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).delete(completion: completion)
        }
    }
    
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
