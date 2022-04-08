import Firebase
typealias FirestoreCompletion = (Error?) -> Void // 사용하기 더 쉽도록 새로운 유형의 이름을 만듬
// 완료 핸들러의 약식으로 표기법?

struct UserService {
    
    // MainController에서 사용
    static func fetchUser(completion: @escaping(User) -> Void ) {    // Model 폴더에 User 클래스에서 만든 User 구조체 사용
        guard let uid = Auth.auth().currentUser?.uid else { return }    // firebase에서 현재 사용자의 UID를 담는다.
        COLLECTION_USERS.document(uid).getDocument { snapshot, error in // User 문서 -> 현재 사용자 uid로 된 문서안에 데이터 가져오기
            guard let dictionary = snapshot?.data() else { return }     // 데이터를 가져왔다면 변수에 담기
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
    
    // 현재 사용자가 해당 사용자를 follow 한다
    static func followUser(uid: String, completion: @escaping(FirestoreCompletion)){
        guard let currentUid = Auth.auth().currentUser?.uid else { return }     // 현재 사용자
        // following 이름의 컬렉션에 현재 로그인된 계정의 문서를 만들고 그 문서에 user-following 컬렉션을 만들어서 해당 uid를 저장한다
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).setData([:]) { error in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).setData([:], completion: completion)
        }
    }
    
    // 현재 사용자가 해당 사용자를 unfollowe 한다
    static func unfollowUser(uid: String, completion: @escaping(FirestoreCompletion)) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }     // 현재 사용자
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).delete { error in
            COLLECTION_FOLLOWERS.document(uid).collection("user-followers").document(currentUid).delete(completion: completion)
        }
    }
    
    
    
    // 현재 사용자가 선택된 사용자를 followed 했는지 확인
    // follow 체크하는것들 중에서 얘만 Model이랑 직접적으로 연결되어 있지 않고 firebase와 통신해서 그에따른 값인 true false만 리턴한다.
    // follow를 해도 화면을 뒤로 갔다가 다시 follow한 사용자의 페이지로 돌아가면 follow를 하기 처음으로 화면이 돌아와 있었다.
    // @escaping(Bool) 이므로 follow가 되어있다면 true 안되어있다면 false를 리턴한다
    static func checkIfUserIsFollowed(uid: String, completion: @escaping(Bool) -> Void) {
        guard let currentUid = Auth.auth().currentUser?.uid else { return }     // 현재 사용자
        COLLECTION_FOLLOWING.document(currentUid).collection("user-following").document(uid).getDocument { (snapshot, error) in
            guard let isFollowed = snapshot?.exists else { return }
            // exists: Snapshot에 데이터가 포함되어 있으면 true 아니면 false 리턴
            completion(isFollowed)  // true, false 둘 중 하나가 나올텐데 @escaping(Bool)에 값이 들어가게 된다?
        }
    }
    
    
    // 선택한 사용자의 팔로우 팔로잉 포스트의 수를 표시
    // Model에 User에서 만든 UserState를 사용
    static func fetchUserStats(uid: String, completion: @escaping(UserStats) -> Void) {
        // 해당 사용자의(uid) user-followers의 콜렉션에 있는 정보를 다 가져온다(getDocuments)
        // error는 없을거니 _로 넣는다
        COLLECTION_FOLLOWERS.document(uid).collection("user-followers").getDocuments { (snapshot, _) in
            let followers = snapshot?.documents.count ?? 0      // document 전체의 count수 비어있다면 0을 followers에 넣는다.
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
