import UIKit

// A를 로그인한 상태에서 로그아웃하고 B를 로그인 했는데 프로필은 여전히 A를 나타냈다 이 상태에서 앱을 재 실행시키니 B로 새로고침이 되었다.
// 로그인이 올바르게 되서 LoginController이 올바르게 닫히면 MainTab에 대리자로 위임해서 User를 새로 고침한다


// delegate = self 하면 필수로 뭐 하라고 나오는데 내가 그걸 직접 만들어 주는거 인듯
protocol AuthenticationDelegate: class {    // class 키워드: 해당 프로토콜을 class에서만 사용할 수 있게한다 struct 사용불가
    func authenticationDidComplete()           // class protocol로 만든 이유는 weak를 사용하기 위해?
}


class LoginController: UIViewController{
    
    // MARK: Properties
    
    private var viewModel = LoginViewModel()    // 이것도 var가 아닌 let으로 바꿨더니 사용하려던 곳에 에러가 났다?
    weak var delegate: AuthenticationDelegate?
    // delegate를 weak로 만든 이유는 유지 주기를 피할려고
    // 이거 let으로 만들었더니 LoginController 이니셜라이즈 필요하다고 에러
    // weak 메모리 누수와 관련
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        imageView.contentMode = .scaleAspectFill        // 이거 여러옵션 비교글 올리기
        return imageView
    }()
    
    private let emailField: UITextField = {     // 사용자 정의 하위클래스를 생성하여 코드가 깔끔해졌다
        let textField = CustomTextField(placeholder: "Email")
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        return textField
    }()
    
    private let passwordField: CustomTextField = { // 중요! 위에처럼 UITextField라고 써도 되고 커스텀 타입으로 사용해도 됨 즉 커스텀은 기존 타입에 내가 옵션을 추가 한것
        let textField = CustomTextField(placeholder: "Password")
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)    // 이 값이 없으면 제일 처음에 배경색이 투명색을 나옴
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(tapLogin), for: .touchUpInside)
        return button
    }()
    
    private let forgotButton: UIButton = {      // 사용자 정의 하위클래스를 생성하여 코드가 깔끔해졌다
        let button = UIButton(type: .system)
        button.attributed(first: "Forgot your password?", second: "Get help signing in.")
        return button
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributed(first: "Don't have an account?", second: "Sign Up")
        button.addTarget(self, action: #selector(tapRegister), for: .touchUpInside) // 여기서 self는 LoginController 클래스를 참조한다 즉 self는 작업을 처리할 클래스다
        // 다른곳은 LoginController.self 하면 됫는데 여기는 에러가 남
        return button
    }()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.barStyle = .black // 이걸 사용하면 네비게이션 위에 상태바들이 다크모드 on/off 상관없이 흰색을 띰
        gradientBackground()
        view.addSubview(iconImage)
        iconImage.centerX(inView: view)
        iconImage.setDimensions(height: 80, width: 120)
        iconImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailField, passwordField, loginButton,forgotButton])
        // 계속해서 위치를 잡을 필요가 없이 stack view 하나만 위치를 잡아주면 나머지는 자동으로 위치가 잡힘 스택뷰의 장점
        // 로고 이미지는 높이를 다르게 줘야하기 때문에 스택뷰에 넣지않고 따로 만든것 같다
        stack.axis = .vertical
        stack.spacing = 20
        view.addSubview(stack)
        stack.anchor(top: iconImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        view.addSubview(registerButton)
        registerButton.centerX(inView: view)
        registerButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
    
    // MARK: Selector
    @objc private func tapRegister(){
        let controller = RegisterController()
        controller.delegate = delegate
        navigationController?.pushViewController(controller, animated: true)
    }
    
    // 로그인 버튼을 누르면 API AuthService에서 만든 구조체 AuthService의 logUserIn 함수를 사용해 통신
    @objc private func tapLogin(){
        
        // guard let email 변수 안에 emailField.text가 들어오면 사용 아니면 return
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        
        // 로그인을 실패했다면 왜 실패했는지 경고창을 만들었으면 좋겠다
        AuthService.logUserIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Debut: \(error.localizedDescription)")
                return
            }
            self.delegate?.authenticationDidComplete() // MainTabController 만든 authenticationDidComplete 함수 실행
        }
    }
    
    // textField delegate를 사용할줄 알았는데 .editingChanged를 사용함 / 텍스트 필드에서 변경될때 마다 호출 됨
    @objc private func textDidChange(sender: UITextField){
        // textField가 emailField인지 passwordField인지 구별하기 위해 sender로 값을 받음
        if sender == emailField{
            viewModel.email = sender.text       // AuthViewModel에서 만든 LoginViewModel 구조체를 사용하고 있다
        } else {
            viewModel.password = sender.text
        }
        
        // email필드와 password필드가 비었는지 확인 LoginViewModel에 만든 formIsValid에서 true false로 리턴
        // AuthViewModel에서 만든 formIsValid가 안 적혀있는데 왜 작동되는지 모르겠음
        updateForm()

    }
}

// 필수는 아니지만 코드를 깔끔하게 해준다, 프로토콜 지향방식
// 아니 근데 왜 이걸보고 깔끔하고 코드에 도움이 된다고 하는걸까? ViewModel만 따로 묶어 놓은거라서?
// 프로토콜은 그거에 맞게 꼭 써야하는 기능을 코드에 적어야 하니까 안정성도?
extension LoginController: FormViewModel {
    func updateForm() {
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTintColor, for: .normal)
        loginButton.isEnabled = viewModel.formIsValid
    }
}
