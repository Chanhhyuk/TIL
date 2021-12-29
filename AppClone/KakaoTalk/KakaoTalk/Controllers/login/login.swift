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
            vc.modalPresentationStyle = .fullScreen
            
            class SceneDelegate: UIResponder, UIWindowSceneDelegate {

                var window: UIWindow?
                
                func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
                    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
                    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
                    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
                    guard let scene = (scene as? UIWindowScene) else { return }
                    window = UIWindow(frame: scene.coordinateSpace.bounds)
                    window?.windowScene = scene
                    window?.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.97)  // 모든 화면 약간어두운 흰색
                    window?.tintColor = .black          // 모든 화면 백버튼 글씨색 검은색 설정
                    window?.rootViewController?.modalPresentationStyle = .fullScreen
                    
                    
                    UILabel.appearance().font = UIFont(name: "BMHANNAAir", size: 26)    // 모든 라벨 폰트 변경
                    
            //        UILabel.appearance(whenContainedInInstancesOf: [UIButton.self]).font = UIFont.boldSystemFont(ofSize: 30)
                    UITextField.appearance().tintColor = UIColor(red: 255/255, green: 255/255, blue: 144/255, alpha: 1)         // 모든 텍스트필드 깜빡이는 커서 노란색
                    UITableView.appearance().separatorStyle = .none             // 모든 테이블뷰 밑줄 제거
                    UITableView.appearance().backgroundColor = .clear       // 모든 테이블뷰 바탕 투명색
                    UITableViewCell.appearance().backgroundColor = .clear   // 모든 테이블뷰셀 바탕 투명색/
                    UITableViewCell.appearance().selectionStyle = .none         // 모든 테이블뷰 셀 선택시 색변경되는 하이라이트 정지
                    UIButton.appearance().setTitleColor(.black, for: .normal)   // 모든 버튼글씨 검은색으로 변경
                    
                    // 탭바컨트롤러 객체 생성
                    let tabBarController = UITabBarController()
                    
                    // 컨트롤러 5개를 네비게이션컨트롤러로 뷰 객체 생성
                    let friends = UINavigationController(rootViewController: friends())
                    let chat = UINavigationController(rootViewController: chat())
                    let view = UINavigationController(rootViewController: KakaoTalk.view())
                    let shopping = UINavigationController(rootViewController: shopping())
                    let seeMore = UINavigationController(rootViewController: seeMore())
                    
                    // 탭바 아이템 만들기
                    let friendsBtn = UITabBarItem(title: nil, image: UIImage(named: "friendOff"), selectedImage: UIImage(named: "friendOn") )
                    let chatBtn = UITabBarItem(title: nil, image: UIImage(named: "chatOff"), selectedImage: UIImage(named: "chatOn") )
                    let viewBtn = UITabBarItem(title: nil, image: UIImage(named: "viewOff"), selectedImage: UIImage(named: "viewOn") )
                    let shoppingBtn = UITabBarItem(title: nil, image: UIImage(named: "shopOff"), selectedImage: UIImage(named: "shopOn") )
                    let seeMoreBtn = UITabBarItem(title: nil, image: UIImage(named: "otherOff"), selectedImage: UIImage(named: "otherOn") )
                    
                    // 탭바 아이템 적용
                    friends.tabBarItem = friendsBtn
                    chat.tabBarItem = chatBtn
                    view.tabBarItem = viewBtn
                    shopping.tabBarItem = shoppingBtn
                    seeMore.tabBarItem = seeMoreBtn
                    
                    // 탭바 컨트롤러가 5개의 뷰 객체를 제어하도록 만들기
                    tabBarController.viewControllers = [friends, chat, view, shopping, seeMore]
                    
                    let loginView = false
                    if loginView == true{
                        window?.rootViewController = tabBarController
                    }else{
                        window?.rootViewController = initial()
                    }
                    
                    window?.makeKeyAndVisible()
                    
                }

                func sceneDidDisconnect(_ scene: UIScene) {
                    // Called as the scene is being released by the system.
                    // This occurs shortly after the scene enters the background, or when its session is discarded.
                    // Release any resources associated with this scene that can be re-created the next time the scene connects.
                    // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
                }

                func sceneDidBecomeActive(_ scene: UIScene) {
                    // Called when the scene has moved from an inactive state to an active state.
                    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
                }

                func sceneWillResignActive(_ scene: UIScene) {
                    // Called when the scene will move from an active state to an inactive state.
                    // This may occur due to temporary interruptions (ex. an incoming phone call).
                }

                func sceneWillEnterForeground(_ scene: UIScene) {
                    // Called as the scene transitions from the background to the foreground.
                    // Use this method to undo the changes made on entering the background.
                }

                func sceneDidEnterBackground(_ scene: UIScene) {
                    // Called as the scene transitions from the foreground to the background.
                    // Use this method to save data, release shared resources, and store enough scene-specific state information
                    // to restore the scene back to its current state.
                }

            }

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

