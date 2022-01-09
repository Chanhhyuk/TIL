import Foundation
import FirebaseDatabase

final class DatabaseManager {   // 데이터베이스 관리자 역할을 할거기 때문에 하위클래스로 분류할 수 없게 final 생성
    static let shared = DatabaseManager()   // 읽기 및 쓰기 액세스를 쉽게 하기 위해 싱글톤과 정적상수
    
    private let database = Database.database().reference()
}

extension DatabaseManager {
    // 이메일의 유효성을 검사함
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
    
    // 데이터 베이스에 새 사용자를 삽입한다.
    public func insertUser(with user: ChatAppUser){
        database.child(user.safeEmail).setValue([
            "first_name": user.firstName,
            "last_name": user.lastName
        ])
    }
}

struct ChatAppUser {
    let firstName: String
    let lastName: String
    let emailAddress: String
//    let profilePictureUrl: String
    
    var safeEmail: String {
        var safeEmail = emailAddress.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        return safeEmail
    }
    
}
