import UIKit
// 프로필 헤더에 관련된 데이터들을 가공

struct ProfileHeaderViewModel {
    let user: User      // User로 가보면 객체가 dictionary로 채워지게 우리가 만든것을 볼 수 있다
    // Profile을 채우려면 User 가 필요하다
    init(user: User) { self.user = user } // 여기서 앞의 user는 맨위 let user, 뒤에 user는 init 매개변수 user 구분을 위해 self를 붙임
    
    var fullname: String { return user.fullname }
    var profileImageUrl: URL? { return URL(string: user.profileImageUrl) }
    // 얘만 왜 타입이 URL일까? 업로드 할때 다른건 String로 이미지만 다른 형식으로 해서 그런걸까?  return은 왜 저 모양인지?
    
    var followButtonText: String {
        if user.isCurrentUser {
            return "Edit Profile"
        }
        return user.isFollowed ? "Following" : "Follow"     // follwed가 true값이면 following
    }
    
    // User 모델에서 만든 데이터 형식을 사용
    var followButtonBackgroundColor: UIColor { return user.isCurrentUser ? .white : .systemBlue }
    var followButtonTextColor: UIColor { return user.isCurrentUser ? .black : .white }
    var numberOfFollowers: NSAttributedString { return attributedText(value: user.stats.followers, label: "followers") }
    var numberOfFollowing: NSAttributedString { return attributedText(value: user.stats.following, label: "following") }
    var numberOfPosts: NSAttributedString { return attributedText(value: user.stats.posts, label: "posts") }
    
    
    // 글자는 진하게 숫자는 보통글씨체로
    private func attributedText(value: Int, label: String) -> NSAttributedString {
        let attributeText = NSMutableAttributedString(string: "\(value)\n", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributeText.append(NSAttributedString(string: label, attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray ]))
        return attributeText
    }
    
}
