// 로그인 뷰
import UIKit
import SafariServices       // 사파리로 웹 페이지를 들어가기 위한

class LoginViewController: UIViewController {
    
    struct Constants {      // 이렇게 사용하면 모든 설정값을(이거 같은경우 cornerRaduis 값을) 똑같이 통합할 수 있다.
        static let cornerRadius: CGFloat = 8.0
    }
    
    private let usernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "이메일을 입력하세요..."
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.placeholder = "비밀번호를 입력하세요..."
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.backgroundColor = .secondarySystemBackground
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for:.normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("Terms of Servicd", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let privacyButton: UIButton = {
            let button = UIButton()
            button.setTitle("Privacy Policy", for: .normal)
            button.setTitleColor(.secondaryLabel, for: .normal)
            return button
    }()

    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("New User? Create an Account", for: .normal)
        return button
    }()
    
    private let headerView: UIView = {
        let header = UIView()
        header.clipsToBounds = true
        let backgroundImageView = UIImageView(image: UIImage(named: "gradient"))
        header.addSubview(backgroundImageView)
        return header
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        view.backgroundColor = .systemBackground        // 이거 사용하는게 다크모드와 관련되어 있다
        usernameEmailField.delegate = self
        passwordField.delegate = self
        
        loginButton.addTarget(self, action: #selector(didTapLoginButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTapCreateAccountButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTapTermsButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTapPrivacyButton), for: .touchUpInside)
    }
    
    
    // 레이아웃 구성할 곳
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        headerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        
        usernameEmailField.translatesAutoresizingMaskIntoConstraints = false
        usernameEmailField.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 50).isActive = true
        usernameEmailField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        usernameEmailField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:  0.8).isActive = true
        usernameEmailField.heightAnchor.constraint(equalToConstant: 60).isActive = true

        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.topAnchor.constraint(equalTo: usernameEmailField.bottomAnchor, constant: 30).isActive = true
        passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:  0.8).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 30).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier:  0.8).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        createAccountButton.translatesAutoresizingMaskIntoConstraints = false
        createAccountButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30).isActive = true
        createAccountButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        createAccountButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
        createAccountButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        termsButton.translatesAutoresizingMaskIntoConstraints = false
        termsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        termsButton.bottomAnchor.constraint(equalTo: privacyButton.topAnchor, constant: -10).isActive = true
        termsButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.6).isActive = true
        termsButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        privacyButton.translatesAutoresizingMaskIntoConstraints = false
        privacyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        privacyButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        privacyButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3).isActive = true
        privacyButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        configureHeaderView()
    }
    
    // 헤더 뷰 안에 이미지 뷰(로고) 추가
    private func configureHeaderView(){
        guard headerView.subviews.count == 1 else{
            return
        }
        guard let backgroundView = headerView.subviews.first else {
            return
        }
//        backgroundView.frame = headerView.bounds 이거 취소했더니 배경 나옴
        
        // 인스타그램 로고 추가
        let imageView = UIImageView(image: UIImage(named: "text"))
        headerView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: headerView.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    private func addSubview() {
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccountButton)
        view.addSubview(headerView)
    }
    
    @objc private func didTapLoginButton() {
//        passwordField.resignFirstResponder()
//        usernameEmailField.resignFirstResponder()
        // 유효성 검사
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
                  return
              }
    }
    
    // 사파리를 통해 지정된 링크 이동
    @objc private func didTapTermsButton() {
        guard let url = URL(string:"https://help.instagram.com/581066165581870/?helpref=hc_fnav") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    // 사파리를 통해 지정된 링크 이동
    @objc private func didTapPrivacyButton() {
        guard let url = URL(string:"https://help.instagram.com/519522125107875") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTapCreateAccountButton() {
        let vc = RegistrationViewController()
        present(vc, animated: true)
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameEmailField {
            passwordField.becomeFirstResponder()
        }else {
            didTapLoginButton()
        }
        return true
    }
}
