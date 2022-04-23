import UIKit
import Firebase
import CoreMedia

struct PostService {
    
    // static으로 선언하지 않을경우 UploadPostController에서 PostService를 사용할때 PostService(). 생성자로 사용해야 한다
    // post 작성하면 3가지 정보 업로드할 문장, 업로드할 사진, 업로드하는 유저내용(이름)을 firebase에 보냄
    static func uploadPost(caption: String, image: UIImage, user: User, completion: @escaping(FirestoreCompletion)) {   // UserService에서 만든 typealias 사용
        guard let uid = Auth.auth().currentUser?.uid else { return }
        // API ImageUploader 구조체 사용
        ImageUploader.uploadImage(image: image) { imageUrl in
            // Model Post있는 timestamp, caption 등등 사용
            let data = ["caption": caption, "timestamp": Timestamp(date: Date()), "likes":0, "imageUrl": imageUrl, "ownerUid": uid, "ownerImageUrl": user.profileImageUrl, "ownerUsername": user.username ] as [String: Any]
            
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
        }
    }
    
    // 게시글을 패치할때
    static func fetchPosts(completion: @escaping([Post]) -> Void) {     // 모든 게시글을 불러온다
        // API를 가져올때 order(by: timestamp) timestamp 기준으로 최신순으로 정렬
        COLLECTION_POSTS.order(by: "timestamp", descending: true).getDocuments { snapshot, Error in
            guard let documents = snapshot?.documents else { return }
            let posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data()) })
            completion(posts)
        }
    }
    
    // 프로필 컨트롤러에서 현재 로그인된 user의 게시글 이미지 목록
    static func fetchPosts(forUser uid: String, completion: @escaping([Post]) -> Void) {
        // whereField로 특정필드(ownerUid)
        let query = COLLECTION_POSTS.whereField("ownerUid", isEqualTo: uid)
        
        query.getDocuments { snapshot, error in
            guard let documents = snapshot?.documents else { return }
            var posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data())})
            
            // 프로필에서 게시글 사진을 시간정렬순(최신순)으로
            posts.sort { ( post1, post2 ) -> Bool in
                return post1.timestamp.seconds > post2.timestamp.seconds
            }
            
            completion(posts)
        }
    }
    
    static func likePost(post: Post, completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        // 게시물과 다른 사람이기 때문에 게시물을 확인하는게 아닌 현재 로그인 사용자를 확인
        
        COLLECTION_POSTS.document(post.postId).updateData(["likes": post.likes + 1])    // 현재 포스트에 likes를 1 추가
        
        
        // 문서를 두개 추가한다는데 하나가 어떤사람이 이 포스트에 좋아요를 눌렀는지 or
        COLLECTION_POSTS.document(post.postId).collection("post-likes").document(uid).setData([:]) { _ in
            COLLECTION_USERS.document(uid).collection("user-likes").document(post.postId).setData([:], completion: completion)
            
        }
    }
    
    static func unlikePost(post: Post, completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        // 게시물과 다른 사람이기 때문에 게시물을 확인하는게 아닌 현재 로그인 사용자를 확인
//        guard post.likes > 0 else { return }  // 안전장치를 만든다.(좋아요는 음수가 될 수 없다)
        
        COLLECTION_POSTS.document(post.postId).updateData(["likes": post.likes - 1 ])
        // 문서에서 likes 값을 1 줄인다
        COLLECTION_POSTS.document(post.postId).collection("post-likes").document(uid).delete { _ in
            COLLECTION_USERS.document(uid).collection("user-likes").document(post.postId).delete(completion: completion)
        }
    }
    
    
    // 현재 사용자가 좋아요를 눌른 포스트를 확인해서 좋아요 버튼의 색을 알맞게 바꾼다
    static func checkIfUserLikedPost(post: Post, completion: @escaping(Bool) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        COLLECTION_USERS.document(uid).collection("user-likes").document(post.postId).getDocument { snapshot, _ in
            guard let didLike = snapshot?.exists else { return }
            completion(didLike)
        }
    }
    
}
