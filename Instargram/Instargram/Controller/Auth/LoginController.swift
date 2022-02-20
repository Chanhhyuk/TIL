import UIKit

// 로그인하면 기본 tabbar controller에서 올바른 사용자를 가져와야 하기 떄문에
protocol AuthenticationDelegate: class {
    func authenticationComplete()
}

class LoginController: UIViewController{
    
    // MARK: Properties
    // View Model 만든걸 사용하기위해 뷰 모델의 인스턴스 생성
    private var viewModel = LoginViewModel()
    weak var delegate: AuthenticationDelegate?
    // delegate를 weak로 만든 이유는 유지 주기를 피할려고
    
    private let iconImage: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "Instagram_logo_white"))
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let emailField: UITextField = {     // 사용자 정의 하위클래스를 생성하여 코드가 깔끔해졌다
        let textField = CustomTextField(placeholder: "Email")
        return textField
    }()
    
    private let passwordField: UITextField = {
        let textField = CustomTextField(placeholder: "Password")
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(tapLogin), for: .touchUpInside)
        return button
    }()
    
    @objc private func tapLogin(){
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        AuthService.logUserIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Debut: \(error.localizedDescription)")
                return
            }
            self.delegate?.authenticationComplete()

        }
    }
    
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
    @objc private func tapRegister(){
        let controller = RegisterController()
        controller.delegate = delegate
        navigationController?.pushViewController(controller, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldObservers()
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
    
    
    // textField delegate를 사용할줄 알았는데 .editingChanged를 사용함
    func textFieldObservers(){      // 텍스트 필드에서 변경될때 마다 호출 됨
        emailField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    // textField가 emailField인지 passwordField인지 구별하기 위한것
    @objc private func textDidChange(sender: UITextField){ // 입력 매개변수로 내부의 UI 텍스트 필드가 된다
        if sender == emailField{
            viewModel.email = sender.text
        } else {
            viewModel.password = sender.text
        }
        updateForm()
//        print("Debug: \(viewModel.formIsValid)") 타이핑 할때마다 true false값 확인할 수 있음
    }
}

// 필수는 아니지만 코드를 깔끔하게 해준다
extension LoginController: FormViewModel {
    func updateForm() {
        loginButton.backgroundColor = viewModel.buttonBackgroundColor
        loginButton.setTitleColor(viewModel.buttonTintColor, for: .normal)
        loginButton.isEnabled = viewModel.formIsValid
    }
}
