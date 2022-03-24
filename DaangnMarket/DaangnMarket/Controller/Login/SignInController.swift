import UIKit

class SignInController: UIViewController {
    
    // MARK: Properties
    private let topLabel: UILabel = {
        let label = UILabel()
        label.text = "휴대폰 번호를 인증해주세요."
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let topSubLabel: UILabel = {
        let label = UILabel()
        label.text = "당근마켓은 휴대폰 번호로 가입해요. 번호는 안전하게 보관되며 어디에도 공개되지 않아요."
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    private let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.tintColor = .orange
        textField.placeholder = "휴대폰 번호를 입력해주세요"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 3
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let messageButton: UIButton = {
        let button = UIButton()
        button.setTitle("인증문자 받기", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.backgroundColor = .darkGray.withAlphaComponent(0.2)
        button.layer.cornerRadius = 3
        return button
    }()
    
    private let emailFindButton: UIButton = {
        let button = UIButton()
        button.setTitle("휴대폰 번호가 변경되었나요? 이메일로 계정찾기", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        phoneTextField.delegate = self
    }
    
    // MARK: ConfigureUI
    private func configureUI() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.title = ""
        navigationController?.navigationBar.tintColor = .black
        
        let stackView = UIStackView(arrangedSubviews: [topLabel,topSubLabel,phoneTextField,messageButton,emailFindButton])
        stackView.axis = .vertical
        stackView.spacing = 20
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalTo(view.snp.width).multipliedBy(0.95)
            make.height.equalTo(240)
        }
        
        phoneTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        messageButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
    }
}

// MARK: Extension(textField)
extension SignInController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return false }
        
        if text.count >= 9 {
            messageButton.backgroundColor = .darkGray
        } else{
            messageButton.backgroundColor = .darkGray.withAlphaComponent(0.2)
        }
            return true
    }
}
