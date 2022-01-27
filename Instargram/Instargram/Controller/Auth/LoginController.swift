import UIKit

// MARK: Properties
// MARK: Lifecycle

class LoginController: UIViewController{
    
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
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log In", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
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
    @objc private func tapRegister(){
        navigationController?.pushViewController(RegisterController(), animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
}
