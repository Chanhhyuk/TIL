// 게시물에 사용될 데이터들
import Foundation
import Firebase

struct Post {           // 나머지는 변하지 않으므로 let 선언
    let postId: String
    var caption: String // 사용자가 올린 글을 편집할 수도 있기 때문에 var 선언
    var likes: Int      // 좋아요나 caption(게시글) 변할수 있기 때문에 var로 선언
    let imageUrl: String
    let ownerUid: String        // 게시글의 주인을 찾으려고 주인의 uid를 저장 한다
    let timestamp: Timestamp    // 타임스탬프 객체에 대한 액세스 권한을 얻으려면 Firebase를 가져와야 한다
    let ownerImageUrl: String   // 프로필 컨트롤러에 해당 접속자가 올린 글만 추려내려고 작성
    let ownerUsername: String
    var didLike = false
    
    init(postId: String, dictionary: [String: Any]) {
        self.postId = postId
        self.caption = dictionary["caption"] as? String ?? ""
        self.likes = dictionary["likes"] as? Int ?? 0
        self.imageUrl = dictionary["imageUrl"] as? String ?? ""
        self.ownerUid = dictionary["ownerUid"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        self.ownerImageUrl = dictionary["ownerImageUrl"] as? String ?? ""
        self.ownerUsername = dictionary["ownerUsername"] as? String ?? ""
        
    }
    
}
