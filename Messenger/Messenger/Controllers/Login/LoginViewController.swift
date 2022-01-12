// 로그인 뷰
import UIKit
import FirebaseAuth
import FBSDKLoginKit

class LoginViewController: UIViewController {
    
    private let scrollView: UIScrollView = {    // 딱히 테이블 뷰는 필요없지만 스크롤은 줘야 할떄 스크롤뷰를 사용
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true         // 스크롤뷰에 속해있는 나머지 subview가 짤리지 않게 방지
        return scrollView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit // 이미지를 비율에 맞게 늘린다.
        return imageView
    }()
    private let emailField: UITextField = {
        let field = UITextField()
        field.autocapitalizationType = .none    // 첫글자 대문자 끄기
        field.autocorrectionType = .no          // 자동고침 끄기
        field.returnKeyType = .continue
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Email Address..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.returnKeyType = .done
        field.layer.cornerRadius = 12
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.placeholder = "Password..."
        field.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        field.leftViewMode = .always
        field.backgroundColor = .white
        return field
    }()
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Log In", for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)       // ? 왜 붙일까?
        return button
    }()

    private let facebookLoginButton: FBLoginButton = {
        let button = FBLoginButton()
        button.permissions = ["email", "public_profile"]
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Log In"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Register", style: .done
                                                            , target: self, action: #selector(didTapRegister))

//        facebookLoginButton.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        
        // Add subview
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        scrollView.addSubview(emailField)
        scrollView.addSubview(passwordField)
        scrollView.addSubview(loginButton)
        scrollView.addSubview(facebookLoginButton)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()       // 이거 안써도 되던데 써야하는이유
        scrollView.frame = view.bounds
        
        let size = scrollView.width / 3
        imageView.frame = CGRect(x: (scrollView.width-size)/2, y: 20, width: size, height: size)
        emailField.frame = CGRect(x: 30, y: imageView.bottom+40, width: scrollView.width-60, height: 52)
        passwordField.frame = CGRect(x: 30, y: emailField.bottom+20, width: scrollView.width-60, height: 52)
        loginButton.frame = CGRect(x: 30, y: passwordField.bottom+20, width: scrollView.width-60, height: 52)
        facebookLoginButton.frame = CGRect(x: 30, y: loginButton.bottom+10, width: scrollView.width-60, height: 52)
        
        facebookLoginButton.frame.origin.y = loginButton.bottom+20
    }
    
    
    @objc private func loginButtonTapped() {
        
        // 유효성검사: 로그인 버튼을 누를때 이메일과 패스워드가 형식에 맞게 작성됫는지 확인
        guard let email = emailField.text, let password = passwordField.text, !email.isEmpty, !password.isEmpty, password.count >= 6 else {
            alertUserLoginError()
            return
        }
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] authResult, error in
            guard let strongSelf = self else {
                return
            }
            
            guard let result = authResult, error == nil else {
                print("Failed to log in user with email: \(email)")
                return
            }
            let user = result.user
            print("Logged In User: \(user)")
            strongSelf.navigationController?.dismiss(animated: true, completion: nil)
        })
    }

    
    
    func alertUserLoginError() {    // 로그인 에러 알림창
        let alert = UIAlertController(title: "Woops", message: "Please enter all information to log in", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    
    @objc private func didTapRegister(){
        let vc = RegisterViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailField {
            passwordField.becomeFirstResponder()
        }else if textField == passwordField {
            loginButtonTapped()
        }
        
        return true
    }
}

// 페이스북 로그인
extension LoginViewController: LoginButtonDelegate{
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        // 아무작업도 하지 않을것
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        guard let token = result?.token?.tokenString else {     // 토큰을 가져옴
            print("User failed to log in with facebook")        // 토큰을 가져오지 못했다면 print 경고문
            return
        }
        let facebookRequest = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields":"email,name"], tokenString: token, version: nil, httpMethod: .get)
        facebookRequest.start { _, result, error in
            guard let result = result as? [String: Any],
                  error == nil else {
                      print("Failed to make facebook graph request")
                      return
                  }
            
            guard let userName = result["name"] as? String,
                  let email = result["email"] as? String else {
                      print("Failed to get email and name from fb result")
                      return
                  }
            let nameComponents = userName.components(separatedBy: " ")
            guard nameComponents.count == 2 else {
                return
            }
            let firstName = nameComponents[0]
            let lastName = nameComponents[1]
            
            DatabaseManager.shared.userExists(with: email) { exists in
                if !exists {
                    DatabaseManager.shared.insertUser(with: ChatAppUser(firstName: firstName, lastName: lastName, emailAddress: email))
                }
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: token)
            FirebaseAuth.Auth.auth().signIn(with: credential, completion: {[weak self] authResult, error in
                guard let strongSelf = self else {
                    return
                }
                
                guard authResult != nil, error == nil else {
                    if let error = error {
                        print("Facebook credential login failed, MFA may be needed - \(error)")
                    }
                    return
                }
                print("Successfully logged user in")
                strongSelf.navigationController?.dismiss(animated: true, completion: nil)
            })
        }
        
    }
}
