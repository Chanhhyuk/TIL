// 로그인 했다면 여기가 main 로그인 하지 않았다면 로그인 창으로 바로 넘어간ㄷ.
import UIKit

class ConversationsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 사용자가 로그인 했는지 확인 로그인했으면 화면을 유지하고 하지 않았으면 로그인 화면을 표시
        
        let isLoggedIn = UserDefaults.standard.bool(forKey: "logged_in")
        
        if !isLoggedIn{
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)
        }
    }

}

