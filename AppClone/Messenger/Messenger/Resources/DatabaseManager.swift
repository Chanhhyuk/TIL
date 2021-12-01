import Foundation
import Firebase


// 읽기 및 쓰기 액세스가 용이하도록 싱글톤이 되는 정적 클래스를 만든다
final class DatabaseManager {
    
    static let shared = DatabaseManager()
    let database = Database.database().reference()
    
}

// 계정 관리
extension DatabaseManager {
    
    public func userExists(with email: String, completion: @escaping((Bool) -> Void)) {
        
        // 이메일의 특정문자열 @ % . 문자열로 바꾸는것
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        // 이메일을 이미 존재 하는지 확인
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
    
    // 새 사용자를 DB에 삽입한다
    public func insertUser(with user: ChatAppUser) {
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
