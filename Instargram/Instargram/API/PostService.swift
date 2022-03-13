import UIKit
import Firebase

struct PostService {
    
    // static으로 선언하지 않을경우 UploadPostController에서 PostService를 사용할때 PostService(). 생성자로 사용해야 한다
    static func uploadPost(caption: String, image: UIImage, completion: @escaping(FirestoreCompletion)) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        ImageUploader.uploadImage(image: image) { imageUrl in
            let data = ["caption": caption, "timestamp": Timestamp(date: Date()), "likes":0, "imageUrl": imageUrl, "ownerUid": uid] as [String: Any]
            
            COLLECTION_POSTS.addDocument(data: data, completion: completion)
        }
    }
}
