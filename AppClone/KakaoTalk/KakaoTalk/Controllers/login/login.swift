import UIKit

class login: UIViewController {
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.text = "카카오톡을 시작합니다"
        return label
    }()
    
    private let emailText: UITextField = {
        let textField = UITextField()
        textField.placeholder = "이메일 또는 전화번호"
        return textField
    }()
    
    private let passwordText: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.isSecureTextEntry = true
        return textField
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(topLabel)
        view.addSubview(emailText)
        view.addSubview(passwordText)
    }
    
    override func viewDidLayoutSubviews() {
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        
        emailText.translatesAutoresizingMaskIntoConstraints = false
        emailText.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        emailText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailText.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 50).isActive = true
        
        passwordText.translatesAutoresizingMaskIntoConstraints = false
        passwordText.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        passwordText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordText.topAnchor.constraint(equalTo: emailText.bottomAnchor, constant: 50).isActive = true
        
    }
    
}
