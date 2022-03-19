import UIKit

class RegisterController: UIViewController {
    
    // MARK: Properties
    
    private var viewModel = RegistrationViewModel() // AuthViewModel에서 만든 RegistrationViewModel 사용
    private var profileImage: UIImage?          // 회원가입을 할때 이미지를 설정하기전에는 이미지값이 없기 때문에 옵셔널로 설정
    weak var delegate: AuthenticationDelegate?
    
    // 프로필 이미지
    private let plusPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo") , for: .normal)
        button.addTarget(self, action: #selector(tapPlusPhoto), for: .touchUpInside)
        button.tintColor = .white
        return button
    }()
    
    private let emailField: UITextField = CustomTextField(placeholder: "Email")
    private let passwordField: UITextField = CustomTextField(placeholder: "Password")
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
    
    // 뒤로 가기 (LoginController로 넘어가기)
    private let alreadyButton: UIButton = {
        let button = UIButton(type: .system)
        button.attributed(first: "Already have an account?", second: "Log In") // 사용자 정의 하위클래스를 생성하여 코드가 깔끔해졌다
        button.addTarget(self, action: #selector(tapAlready), for: .touchUpInside)
        return button
    }()
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        textFieldObservers()
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
    
    // MARK: Selector
    @objc private func tapPlusPhoto() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    @objc private func tapSignUp(){
        // 안전하게 풀기위해서 guard let을 사용 (선택사항)
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        guard let fullName = fullNameField.text else { return }
        guard let userName = userNameField.text?.lowercased() else { return }   // .lowercased 소문자인지 확인
        guard let profileImage = self.profileImage else { return }
        // 함수(tapSignUp)안에서 사용할 변수와 class단위에서 사용하는 변수이름이 같기 때문에 구별하기 위해 class 단위에서 사용하는 변수 앞에 self를 붙임
        
        // AuthService에서 생성된 구조체를 이용
        let credentials = AuthCredetials(email: email, password: password, fullname: fullName, username: userName, profileImage: profileImage)
        
        // 회원가입에 양식에 맞지 않으면 print(error) 내용이 나올텐데 이걸 경고문으로 바꾸면 좋을것 같다
        AuthService.registerUser(withCredential: credentials) { error in
            if let error = error {
                print("error:\(error.localizedDescription)")
                return
            }
            self.delegate?.authenticationComplete()     // 회원가입 버튼을 누르면 메인컨트롤러로 가는 것
        }
    }
    
    // 로그인 창으로 이동(뒤로가기)
    @objc private func tapAlready(){
        navigationController?.popViewController(animated: true)
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
    
    
    // MARK: Function
    private func textFieldObservers(){      // 텍스트 필드에서 변경될때 마다 호출 됨
        passwordField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        fullNameField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        userNameField.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
}


// 프로토콜 지향방식
extension RegisterController: FormViewModel {
    func updateForm() {
        signUpButton.backgroundColor = viewModel.buttonBackgroundColor
        signUpButton.setTitleColor(viewModel.buttonTintColor, for: .normal)
        signUpButton.isEnabled = viewModel.formIsValid
    }
}


// 프로필 사진 설정시 앨범을 불러오기 위한 delegate
extension RegisterController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    // 사용자가 사진이나 비디오를 선택하면 호출한다
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let seletedImage = info[.editedImage] as? UIImage else { return }     // 선택된 이미지를 저장한다
        
        profileImage = seletedImage     // 선택한 이미지를 class단위로 생성한 profileImage로 값을 전달후 이걸 다시 api로 보냄
        
        plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
        plusPhotoButton.layer.masksToBounds = true
        plusPhotoButton.layer.borderColor = UIColor.white.cgColor
        plusPhotoButton.layer.borderWidth = 2
        plusPhotoButton.setImage(seletedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        self.dismiss(animated: true, completion: nil)
    }
}
