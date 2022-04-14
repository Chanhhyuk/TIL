import Firebase

struct CommentService{
    
    static func uploadComment(comment: String, postID: String, user: User, completion: @escaping(FirestoreCompletion) ) {
        let data: [String: Any] = ["uid": user.uid,
                                   "comment":comment,
                                   "timestamp":Timestamp(date: Date()),
                                   "username":user.username,
                                   "profileImageUrl": user.profileImageUrl]
        COLLECTION_POSTS.document(postID).collection("comments").addDocument(data: data, completion: completion)
        // post collection에서 postID를 찾아서 comments라는 collection(폴더)을 만들어서 입력받은 데이터를 저장한다?
    }
    
    static func fetchComments(){
        
    }
    
}
