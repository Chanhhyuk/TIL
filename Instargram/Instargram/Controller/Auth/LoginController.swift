import UIKit

// A를 로그인한 상태에서 로그아웃하고 B를 로그인 했는데 프로필은 여전히 A를 나타냈다 이 상태에서 앱을 재 실행시키니 B로 새로고침이 되었다.
// 이것이 해제되면 이 프로토콜을 사용하여 기본 tabbar에 작업을 다시 위임할 것?, 컨트롤러를 새로고침?
protocol AuthenticationDelegate: class {    // class 키워드: 해당 프로토콜을 class에서만 사용할 수 있게한다 struct 사용불가
    func authenticationDidComplete()           // class protocol로 만든 이유는 weak를 사용하기 위해?
}

class LoginController: UIViewController{
    
    // MARK: Properties
    
    private var viewModel = LoginViewModel()    // AuthViewModel에서 만든걸 사용하기위해 뷰 모델의 인스턴스 생성
    weak var delegate: AuthenticationDelegate?
    // delegate를 weak로 만든 이유는 유지 주기를 피할려고
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let emailField: UITextField = {     // 사용자 정의 하위클래스를 생성하여 코드가 깔끔해졌다
        let textField = CustomTextField(placeholder: "Email")
        textField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        return textField
    }()
    
    private let passwordField: UITextField = {
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
extension LoginController: FormViewModel {
    func updateForm() {
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTintColor, for: .normal)
        loginButton.isEnabled = viewModel.formIsValid
    }
}
