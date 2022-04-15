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
    
    static func fetchComments(forPost postID: String, completion: @escaping([Comment]) -> Void) {
        var comments = [Comment]()
        let query = COLLECTION_POSTS.document(postID).collection("comments").order(by: "timestamp", descending: true)
        
        // 스냅샷을 보고 문서가 변경된것을 살피고
        query.addSnapshotListener { snapshot, error in
            snapshot?.documentChanges.forEach({ change in
                if change.type == .added {
                    let data = change.document.data()
                    let comment = Comment(dictionary: data)
                    comments.append(comment)
                }
            })
            completion(comments)
        }
    }
    
}
