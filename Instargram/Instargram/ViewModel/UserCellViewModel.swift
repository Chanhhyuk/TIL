// 서치탭 model
import Foundation

struct UserCellViewModel {
    private let user: User
    
    var profileImageUrl: URL? { // 계산 속성
        return URL(string: user.profileImageUrl)
    }
    
    var username: String {
        return user.username
    }
    
    var fullname: String {
        return user.fullname
    }
    
    init(user: User) {
        self.user = user
    }
}
