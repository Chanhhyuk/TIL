import Foundation
import UIKit

// FeedCell에서 사용할 viewModel을 만든다.
struct PostViewModel {
    var post: Post
    
    var imageUrl: URL? { return URL(string: post.imageUrl) }
    
    var userProfileImageUrl: URL? { return URL(string: post.ownerImageUrl)}
    
    var username: String { return post.ownerUsername}
    
    var caption: String { return post.caption }

    var likes: Int { return post.likes }
    
    var likeButtonTintColot: UIColor {
        return post.didLike ? .red : .black
    }
    
    var likeButtonImage: UIImage? {
        let imageName = post.didLike ? "like_selected" : "like_unselected"
        return UIImage(named: imageName)
    }
    
    var likesLabelText: String {
        if post.likes != 1 {
            return "\(post.likes) likes"    // 2이상이면 복수형이닌까 likes
        } else {
            return "\(post.likes) like"     // 1이면 단수형이니까 like
        }
    }
    
    // 생성자를 만든 이유는?
    init(post: Post) { self.post = post }
    
}
