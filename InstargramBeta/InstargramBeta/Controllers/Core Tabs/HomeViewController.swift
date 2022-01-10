import Firebase
import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {     // HomeViewController가 루트뷰지만 로그인이 되어있지않으면
        super.viewDidAppear(animated)                   // 바로 LoginViewController로 간다
        handleNotAuthenticated()
    }
    
    private func handleNotAuthenticated() {
        // 인증 상태를 확인한다.
        if Auth.auth().currentUser == nil {     // 인증이 되어있지 않다면?
            let loginVC = LoginViewController() // 로그인 뷰 컨트롤러를 띄움
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC, animated: false)
        }
    }


}

