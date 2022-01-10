// 데이터베이스에 관한 관리
import FirebaseDatabase

public class DatabaseManager{ // 데이터베이스 관리자라는 공개 클래스
    static let shared = DatabaseManager() // 단일 인스턴스를 가질 것이기 때문에 정적으로 선언
    
    // 회원 비회원 구분없이 모두가 사용할 공용 함수 추가
    // 여기저기 똑같은 코드를 사용하는게 아니라 여기서 하나를 작성하고 사용할곳에 가져가서 사용?
    
    public func registerNewUser(username: String, email: String, password: String){
        
    }
    
    public func loginUser(username: String?, email: String?, password: String){
        
    }
    
    
}
