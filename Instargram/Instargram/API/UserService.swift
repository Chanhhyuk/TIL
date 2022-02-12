// 사용자 정보를 가져옴
import Firebase
import Foundation

struct UserService {
    static func fetchUser() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        COLLECTION_USERS.document(uid).getDocument { snapshot, ErrorCode in
            print("DEBUG: Snapshot is \(snapshot?.data())")
        }
    }
}
