import Foundation
import FirebaseDatabase

// 상속 또는 상속에의한 재정의가 될 필요가 없다고 판단한 경우 final을 사용
final class DatabaseManager {   // 데이터베이스 관리자 역할을 할거기 때문에 하위클래스로 분류할 수 없게 final 생성
    static let shared = DatabaseManager()   // 읽기 및 쓰기 액세스를 쉽게 하기 위해 싱글톤과 정적상수
    private let database = Database.database().reference()  // DB에 접근하는 코드 입력할때 이걸 꼭 입력해야 한다
}

extension DatabaseManager {
    // 이메일의 유효성을 검사함
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        
        var safeEmail = email.replacingOccurrences(of: ".", with: "-")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "-")
        
        // DB에서 safeEmail이라는 객체를 가져온다(observeSingleEvent) .value 값을
        database.child(safeEmail).observeSingleEvent(of: .value, with: { snapshot in
            guard snapshot.value as? String != nil else {
                completion(false)
                return
            }
            completion(true)
        })
    }
    
    // 데이터 베이스에 새 사용자를 삽입한다.
    public func insertUser(with user: ChatAppUser){     // 파라미터값을 구조체로 넣어서 .으로 값을 사용할 수 있음 with는 뭘까?
        database.child(user.safeEmail).setValue([       // DB에 객체값으로 user.safeEmail을 만들고 setValue로 [키:값]으로 값을 넣는다
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
