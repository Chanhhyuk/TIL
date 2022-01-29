import UIKit

class RegisterController: UIViewController {
    
    private var viewModel = RegistrationViewModel()
    private var profileImage: UIImage?
    // 화면을 열 때 이것에 대한 값이 존재하지 않을 것이기 때문에 따로 생성
    // 옵셔널로 만들고 사용자가 프로필을 선택할 때마다 설정할 것
    
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo") , for: .normal)
        button.addTarget(self, action: #selector(tapPlusPhoto), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    @objc private func tapPlusPhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
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
        button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5)
        button.layer.cornerRadius = 5
        button.setHeight(50)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.addTarget(self, action: #selector(tapSignUp), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    @objc private func tapSignUp(){
        // 안전하게 풀기위해서 guard문을 사용
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        guard let fullName = fullNameField.text else { return }
        guard let userName = userNameField.text else { return }
        guard let profileImage = self.profileImage else { return }
        
        let credentials = AuthCredetials(email: email, password: password, fullname: fullName, username: userName, profileImage: profileImage)
        AuthService.registerUser(withCredential: credentials)
    }
    
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
        textFieldObservers()
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
    
    private func textFieldObservers(){      // 텍스트 필드에서 변경될때 마다 호출 됨
        emailField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullNameField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        userNameField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    @objc private func textDidChange(sender: UITextField){         // 입력 매개변수로 내부의 UI 텍스트 필드가 된다
        if sender == emailField{
            viewModel.email = sender.text
        } else if sender == passwordField {
            viewModel.password = sender.text
        } else if sender == fullNameField {
            viewModel.fullName = sender.text
        } else {
            viewModel.userName = sender.text
        }
        updateForm()
    }
}

extension RegisterController: FormViewModel {
    func updateForm() {
        signUpButton.backgroundColor = viewModel.buttonBackgroundColor
        signUpButton.setTitleColor(viewModel.buttonTintColor, for: .normal)
        signUpButton.isEnabled = viewModel.formIsValid
    }
}

extension RegisterController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    // 사용자가 미디어 유형 선택을 마치면 호출한다
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let seletedImage = info[.editedImage] as? UIImage else { return }     // 선택된 이미지를 저장한다
        
        profileImage = seletedImage
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 2
        plusPhotoButton.setImage(seletedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.dismiss(animated: true, completion: nil)
    }
}
