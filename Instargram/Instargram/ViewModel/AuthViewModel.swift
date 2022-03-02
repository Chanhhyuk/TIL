import UIKit    // UIColor 속성을 사용하기 때문에 UIKit을 사용

protocol AuthViewModel {
    var formIsValid: Bool { get }
    var buttonBackgroundColor: UIColor { get }
    var buttonTintColor: UIColor { get }
    
    // 프로토콜을 잘 준수했는지(해당 속성들을 다 구현했는지) 알려준다.
    // 써보닌깐 필수는 아니라는걸 알것같다 복붙하면되닌깐 근데 코드를 관리하기 위해서 또한 꼭 써야될때도 있을거 같다.
    // 공통속성들(반복해서 사용하는것들은) protocol로 관리
}

// 이건 프로토콜로 선언할께 아니라 각 컨트롤러에서 그냥 함수로 실행해줘도 될듯함
protocol FormViewModel {
    func updateForm()
}


struct LoginViewModel: AuthViewModel {
    var email: String?  // 이거 let으로 선언했더니 뷰 모델 인스턴스 생성할때 꼭 파라미터를 적어줘야 했다
    var password: String?
    
    var formIsValid: Bool {     // 유효성 검사       계산속성
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    // formIsValid에서 반환하는 true false를 바탕으로 작동
    var buttonBackgroundColor: UIColor {      // 계산 속성  // 양식이 유효한지의 대한 기반으로 작동함
        return formIsValid ? #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    }
    
    // formIsValid에서 반환하는 true false를 바탕으로 작동
    var buttonTintColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
}

struct RegistrationViewModel: AuthViewModel{
    var email: String?
    var password: String?
    var fullName: String?
    var userName: String?
    
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false && fullName?.isEmpty == false && userName?.isEmpty == false
    }
    
    var buttonBackgroundColor: UIColor {
        return formIsValid ? #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
    }
    
    var buttonTintColor: UIColor {
        return formIsValid ? .white : UIColor(white: 1, alpha: 0.67)
    }
    
    
}
