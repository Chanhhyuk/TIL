import Foundation

struct UserCellViewModel {
    private let user: User

    // serachController에 사용할 데이터 이미지,이름,닉네임 데이터를 만든다.
    
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
