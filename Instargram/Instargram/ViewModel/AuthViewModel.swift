// 로그인과 회원가입 뷰에서 데이터 값에 따라 동작을 설정하기 위한 viewModel
// UIColor 속성을 사용하기 때문에 UIKit을 사용
// 여기는 근데 viewModel인데 model은 사용하지 않았네? 다른곳은 post나 user를 사용했는데 말이야
import UIKit


// 아 이거 그리고 파일이름이랑 똑같게 할려고 만든거래 LoginViewModel이면 어디 파일에 있는지 모르니까?
protocol AuthViewModel {
    var formIsValid: Bool { get }
    var buttonBackgroundColor: UIColor { get }
    var buttonTintColor: UIColor { get }
    
    // 한번 더 확인하는 느낌?
    // 프로토콜을 잘 준수했는지(해당 속성들을 다 구현했는지) 알려준다.
    // 써보닌깐 필수는 아니라는걸 알것같다 복붙하면되닌깐 근데 코드를 관리하기 위해서 또한 꼭 써야될때도 있을거 같다.
    // 로그인과 회원가입에서 공통으로 쓰인다.
    // 공통속성들(반복해서 사용하는것들은) protocol로 관리
}

// 프로토콜로 선언해도 되고 사용할 컨트롤러마다 updateForm을 만들어서 사용해도 됨
// 아래 프로토콜은 함수를 사용 위에 프로토콜은 계산속성
protocol FormViewModel {
    func updateForm()
}


struct LoginViewModel: AuthViewModel {
    var email: String?  // 이거 let으로 선언하거나 var로 선언했는데 ? 때고 선언하면 LoginViewController에서 인스턴스 생성할때 꼭 파라미터를 적어줘야 했다?
    var password: String?
    
    // View를 업데이트 하는 로직이 Controller 내부에 있는것은 바람직하지 않아서 ViewModel 계산속성으로 작성한다?
    
    // 계산속성, 유효성 검사
    var formIsValid: Bool {
        return email?.isEmpty == false && password?.isEmpty == false
    }
    
    // formIsValid에서 반환하는 true false를 바탕으로 작동
    var buttonBackgroundColor: UIColor {      // 계산 속성  // 양식이 유효한지 확인하는 유효성 검사
        return formIsValid ? #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1) : #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)     // 삼항연산자
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
