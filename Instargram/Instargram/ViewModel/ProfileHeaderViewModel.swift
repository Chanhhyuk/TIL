import UIKit
// 프로필 헤더에 관련된 데이터들을 가공

struct ProfileHeaderViewModel {
    let user: User      // Model 폴더에 User 클래스에 있는 User 구조체를 사용
    init(user: User) { self.user = user } // 여기서 앞의 user는 맨위 let user, 뒤에 user는 init 매개변수 user 구분을 위해 self를 붙임
    
    var fullname: String { return user.fullname }
    var profileImageUrl: URL? { return URL(string: user.profileImageUrl) }
    var followButtonText: String {
        if user.isCurrentUser {     // 만약 접속한 유저를 선택해서 들어갔다면 버튼은 Edit Profile
            return "Edit Profile"
        }
        return user.isFollowed ? "Following" : "Follow"     // follwed가 true값이면 following
    }
    
    var followButtonBackgroundColor: UIColor { return user.isCurrentUser ? .white : .systemBlue }
    var followButtonTextColor: UIColor { return user.isCurrentUser ? .black : .white }
    var numberOfFollowers: NSAttributedString { return attributedText(value: user.stats.followers, label: "followers") }
    var numberOfFollowing: NSAttributedString { return attributedText(value: user.stats.following, label: "following") }
    var numberOfPosts: NSAttributedString { return attributedText(value: user.stats.posts, label: "posts") }
    
    private func attributedText(value: Int, label: String) -> NSAttributedString {
        let attributeText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributeText.append(NSAttributedString(string: label, attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray ]))
        return attributeText
    }
    
}
