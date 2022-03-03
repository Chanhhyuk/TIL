import Foundation

// profileController에서 위쪽부분 header를 채우기 위한 데이터
struct ProfileHeaderViewModel {
    let user: User      // Model 폴더에 User 클래스에 있는 User 구조체를 사용
    
    // profileController에서 필요한 데이터는 fullname과 profileImage이므로 두개만 생성
    var fullname: String {
        return user.fullname
    }
    
    var profileImageUrl: URL? {
        return URL(string: user.profileImageUrl)
    }
    
    init(user: User) {  // User 모델을 초기화함
        self.user = user           // 여기서 앞의 user는 맨위 let user, 뒤에 user는 init 매개변수 user 구분을 위해 self를 붙임
    }
    
}
