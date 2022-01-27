import UIKit

class RegisterController: UIViewController {
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo") , for: .normal)
        button.tintColor = .white
        return button
    }()
    private let emailField: UITextField = CustomTextField(placeholder: "Email")
    
    private let passwordField: UITextField = {
        let textField = CustomTextField(placeholder: "Password")
        textField.isSecureTextEntry = true
        return textField
    }()
    private let fullNameField: UITextField = CustomTextField(placeholder: "Fullname")       // 코드가 훨씬 깔끔해짐
    private let userNameField: UITextField = CustomTextField(placeholder: "UserName")
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()
    
    private let alreadyButton: UIButton = {      // 사용자 정의 하위클래스를 생성하여 코드가 깔끔해졌다
        let button = UIButton(type: .system)
        button.attributed(first: "Already have an account?", second: "Log In")
        button.addTarget(self, action: #selector(tapAlready), for: .touchUpInside)
        return button
    }()
    
    @objc private func tapAlready(){
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientBackground()
        view.addSubview(plusPhotoButton)
        plusPhotoButton.centerX(inView: view)
        plusPhotoButton.setDimensions(height: 140, width: 140)
        plusPhotoButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 32)
        
        let stack = UIStackView(arrangedSubviews: [emailField, passwordField, fullNameField, userNameField, signUpButton])
        // 계속해서 위치를 잡을 필요가 없이 stack view 하나만 위치를 잡아주면 나머지는 자동으로 위치가 잡힘 스택뷰의 장점
        stack.axis = .vertical
        stack.spacing = 20
        view.addSubview(stack)
        stack.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 32, paddingLeft: 32, paddingRight: 32)
        view.addSubview(alreadyButton)
        alreadyButton.centerX(inView: view)
        alreadyButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    }
}
