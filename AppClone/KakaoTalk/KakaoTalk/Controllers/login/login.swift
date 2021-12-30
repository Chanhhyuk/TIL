import UIKit

class login: UIViewController ,UITextFieldDelegate {
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.text = "카카오톡을 시작합니다"
        return label
    }()
    
    private let emailText: UITextField = {
        let textField = UITextField()
        let underLine = UIView()
        textField.placeholder = "이메일 또는 전화번호"
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.returnKeyType = .continue
        
        let clearBtn = UIButton()
        clearBtn.setTitle("✕", for: .normal)
        textField.addSubview(clearBtn)
        textField.rightView = clearBtn
        textField.rightViewMode = .always
        clearBtn.addTarget(self, action: #selector(clearMode), for: .touchUpInside)
        
        underLine.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        textField.addSubview(underLine)
        underLine.translatesAutoresizingMaskIntoConstraints = false
        underLine.widthAnchor.constraint(equalTo: textField.widthAnchor).isActive = true
        underLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        underLine.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10).isActive = true
        
        return textField
    }()
    
    @objc func clearMode(){
        emailText.text = ""
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    private let passwordText: UITextField = {
        let textField = UITextField()
        textField.placeholder = "비밀번호"
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        textField.returnKeyType = .done
        
        let seeBtn = UIButton()
        seeBtn.setTitle("👀", for: .normal)
        textField.addSubview(seeBtn)
        textField.rightView = seeBtn
        textField.rightViewMode = .always
        seeBtn.addTarget(self, action: #selector(seeMode) , for: .touchUpInside)
        
        let underLine = UIView()
        underLine.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        textField.addSubview(underLine)
        underLine.translatesAutoresizingMaskIntoConstraints = false
        underLine.widthAnchor.constraint(equalTo: textField.widthAnchor).isActive = true
        underLine.heightAnchor.constraint(equalToConstant: 2).isActive = true
        underLine.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 10).isActive = true
        
        return textField
    }()
    
    var iconClick = true
    @objc func seeMode(){
        if(iconClick == true) {
            passwordText.isSecureTextEntry = false
        } else {
            passwordText.isSecureTextEntry = true
        }
        iconClick = !iconClick
    }
    
    
    private let loginBtn: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.layer.cornerRadius = 20
        button.setTitleColor(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3), for: .normal)
        button.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)
        button.addTarget(self, action: #selector(mainMove), for: .touchUpInside)
        return button
    }()
    
    private let regiBtn: UIButton = {
        let button = UIButton()
        button.setTitle("새로운 카카오계정 만들기", for: .normal)
        button.layer.cornerRadius = 20
        button.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)
        return button
    }()
    
    private let findLabel: UILabel = {
        let label = UILabel()
        label.text = "카카오계정 또는 비밀번호 찾기"
        label.font = UIFont(name: "BMHANNAPro", size: 14)
        return label
    }()
    
    @objc func mainMove() {
        let alert = UIAlertController(title: "아이디와 비밀번호를 확인해주세요.", message: "", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler : nil )
        alert.addAction(okAction)
        
        if passwordText.text == "apple"{
            let vc = friends()
            friends().modalPresentationStyle = .fullScreen
            
            
            
            
            

            self.present(vc, animated: false)
        }else{
            self.present(alert, animated: false)
        }
        
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let strLength = passwordText.text?.count ?? 0
        let lngthToAdd = string.count
        let lengthCount = strLength + lngthToAdd
        
        if lengthCount > 6{
            loginBtn.backgroundColor = .yellow
            loginBtn.setTitleColor(.black, for: .normal)
        }else {     // 기본 설정한 값으로 되라고 간단히 코드 하고 싶은데 몰라서 기존값을 복붙하게 됨
            loginBtn.backgroundColor = UIColor(red: 211/255, green: 211/255, blue: 211/255, alpha: 1)
            loginBtn.setTitleColor(UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3), for: .normal)
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          if textField == emailText {
            passwordText.becomeFirstResponder()
          } else {
            passwordText.resignFirstResponder()
          }
        
        if textField == passwordText {
            mainMove()
        }
    
      return true
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(topLabel)
        view.addSubview(emailText)
        emailText.delegate = self
        view.addSubview(passwordText)
        passwordText.delegate = self
        view.addSubview(loginBtn)
        view.addSubview(regiBtn)
        view.addSubview(findLabel)
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
        
        loginBtn.translatesAutoresizingMaskIntoConstraints = false
        loginBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        loginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginBtn.topAnchor.constraint(equalTo: passwordText.bottomAnchor, constant: 50).isActive = true
        loginBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        regiBtn.translatesAutoresizingMaskIntoConstraints = false
        regiBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        regiBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        regiBtn.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 10).isActive = true
        regiBtn.heightAnchor.constraint(equalTo: loginBtn.heightAnchor).isActive = true
        
        findLabel.translatesAutoresizingMaskIntoConstraints = false
        findLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        findLabel.topAnchor.constraint(equalTo: regiBtn.bottomAnchor, constant: 10).isActive = true
        
    }
    
}

