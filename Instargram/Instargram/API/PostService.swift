import UIKit
import Firebase
import CoreMedia

struct PostService {
    
    // static으로 선언하지 않을경우 UploadPostController에서 PostService를 사용할때 PostService(). 생성자로 사용해야 한다
    static func uploadPost(caption: String, image: UIImage, user: User, completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        ImageUploader.uploadImage(image: image) { imageUrl in
            let data = ["caption": caption, "timestamp": Timestamp(date: Date()), "likes":0, "imageUrl": imageUrl, "ownerUid": uid, "ownerImageUrl": user.profileImageUrl, "ownerUsername": user.username ] as [String: Any]
            
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
        }
    }
    
    static func fetchPosts(completion: @escaping([Post]) -> Void) {
        
        COLLECTION_POSTS.getDocuments { snapshot, Error in
            guard let documents = snapshot?.documents else { return }
            let posts = documents.map({ Post(postId: $0.documentID, dictionary: $0.data()) })
            completion(posts)
        }
    }
    
}
