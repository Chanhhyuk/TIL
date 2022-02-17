import UIKit
import Firebase

class MainTabController: UITabBarController {
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabController()
        checkIfUserIsLoggedIn()
//        logout()
    }
    
    // MARK: API
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let controller = LoginController()
                controller.delegate = self
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    
    
    // MARK: Helpers
    // 뷰 컨트롤러의 인스턴스를 각각의 내부에 저장하는 것
    // 컨트롤러의 인스턴스를 생성하고 있다 () 생성자
    private func tabController(){
//        let layout = UICollectionViewLayout()     // 많이 하는 실수 에러도 안남
        let layout = UICollectionViewFlowLayout()   // 이거 해봤는데 바로 직접적으로 적어줘도 되었다
        let feed = naviController(unseletedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedController(collectionViewLayout: layout))
        let search = naviController(unseletedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchController() )
        let imageSelector = naviController(unseletedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: ImageSelectorController() )
        let notification = naviController(unseletedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationController() )
        let profile = naviController(unseletedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: ProfileController(collectionViewLayout: layout) )
        // ()는 생성자이며
        // 인스턴스를 만들고 있다
        
        // UITabbarController을 상속받아서 얻는 속성 viewControllers = []
        // 위에는 컨트롤러 인스턴스를 생성만 한거고 이 배열에서 사용하면 컨트롤러의 인스턴스를 나타낸다
        viewControllers = [feed, search, imageSelector, notification, profile]
        // 위에 변수에 따로 저장하는게 아니라 생성자형태로 바로 넣을 수 있다 하지만 이렇게 하는게 좋다
        // 아래처럼 코드가 지저분해지기 때문
//        viewControllers = [naviController(unseletedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedController())]
        tabBar.tintColor = .black
    }
    
    // tabbar를 설정해주는건데 왜 네비게이션 컨트롤러를 리턴하는지 모르겠다...
    // tabbar를 설정할 때 좀더 수월하게 하기 위해 함수 설정
    private func naviController(unseletedImage: UIImage, selectedImage: UIImage, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = unseletedImage           // 버튼이 선택되지 않았을때 이미지
        nav.tabBarItem.selectedImage = selectedImage    // 버튼이 선택되었을때 이미지
        nav.navigationBar.tintColor = .black            // 네비게이션바 텍스트 색
        return nav
    }
}

extension MainTabController: AuthenticationDelegate {
    func authenticationComplete() {
        self.dismiss(animated: true, completion: nil)
    }
}
