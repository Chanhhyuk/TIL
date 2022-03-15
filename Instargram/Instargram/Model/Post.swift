import Foundation
import Firebase
// Post에서 사용할 데이터 객체를 만듬

struct Post {
    var caption: String
    var likes: Int      // 좋아요 수는 변할수 있기 때문에 var로 선언
    let imageUrl: String
    let ownerUid: String
    let timestamp: Timestamp
    let postId: String
    
    
    init(postId: String, dictionary: [String: Any]) {
        self.postId = postId
        self.caption = dictionary["caption"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.ownerUid = dictionary["ownerUid"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }
    
}
