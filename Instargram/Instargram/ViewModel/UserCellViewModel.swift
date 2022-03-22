import Foundation

struct UserCellViewModel {
    private let user: User
    
    // serachController에 사용할 데이터 이미지,이름,닉네임 데이터를 만든다.
    var profileImageUrl: URL? { return URL(string: user.profileImageUrl) }
    var username: String { return user.username }
    var fullname: String { return user.fullname }
    
    init(user: User) { // init으로 초기화하고 초기화블록에 해당 속성을 설정
        self.user = user
    }
}
