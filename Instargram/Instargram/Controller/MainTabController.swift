import UIKit
import Firebase
import YPImagePicker

class MainTabController: UITabBarController {
    
    private var user: User? {
        didSet{
            guard let user = user else { return }
            tabController(withUser: user)
        }
    }
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUser()
        checkIfUserIsLoggedIn()
    }
    
    // MARK: API
    func fetchUser() {
        UserService.fetchUser { user in
            self.user = user
            self.navigationItem.title = user.username
        }
    }
    
    
    // 로그인 상태를 확인하고 아니라면 로그인 컨트롤러를 보여준다.
    // 로그인을 했다면 rootController이 MainController이므로 이 함수는 작동하지 않으므로 MainController을 보여준다
    func checkIfUserIsLoggedIn() {
        if Auth.auth().currentUser == nil {     // 로그인 상태인지 확인, 사용자프로필이 없다면(nil)
            DispatchQueue.main.async {          // API 호출을 포함하고(Auth.auth().currentUser) 있기 때문에 메인쓰레드로 다시 이동해야 한다?
                // 화면표시, UI변경과 같이 UI업데이트와 관련된 작업을 수행할때는 메인쓰레드에서 해야한다?
                let controller = LoginController()
                controller.delegate = self          // LoginController만든 프로토콜 AuthenticationDelegate을 사용
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
            }
        }
    }
    
    
    
    // MARK: Helpers
    private func tabController(withUser user: User){
//        let layout = UICollectionViewLayout()     // 많이 하는 실수 에러도 안남
        let layout = UICollectionViewFlowLayout()   // 이거 해봤는데 바로 직접적으로 적어줘도 되었다
        let feed = naviController(unseletedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedController(collectionViewLayout: layout))
        let search = naviController(unseletedImage: #imageLiteral(resourceName: "search_unselected"), selectedImage: #imageLiteral(resourceName: "search_selected"), rootViewController: SearchController() )
        let imageSelector = naviController(unseletedImage: #imageLiteral(resourceName: "plus_unselected"), selectedImage: #imageLiteral(resourceName: "plus_unselected"), rootViewController: ImageSelectorController() )
        let notification = naviController(unseletedImage: #imageLiteral(resourceName: "like_unselected"), selectedImage: #imageLiteral(resourceName: "like_selected"), rootViewController: NotificationController() )
        let profileController = ProfileController(user: user)
        let profile = naviController(unseletedImage: #imageLiteral(resourceName: "profile_unselected"), selectedImage: #imageLiteral(resourceName: "profile_selected"), rootViewController: profileController)
        // ()는 생성자이며 컨트롤러의 인스턴스를 생성하고 있다 ()?
        // 뷰 컨트롤러의 인스턴스를 각각의 내부에 저장하는 것?
        
        // UITabbarController을 상속받아서 얻는 속성 viewControllers = []
        // 위에는 컨트롤러 인스턴스를 생성만 한거고 이 배열에서 사용하면 컨트롤러의 인스턴스를 나타낸다
        viewControllers = [feed, search, imageSelector, notification, profile]
        // 위에 변수에 따로 저장하는게 아니라 생성자형태로 바로 넣을 수 있다 하지만 이렇게 하는게 좋다
        // 아래처럼 코드가 지저분해지기 때문
//        viewControllers = [naviController(unseletedImage: #imageLiteral(resourceName: "home_unselected"), selectedImage: #imageLiteral(resourceName: "home_selected"), rootViewController: FeedController())]
        tabBar.tintColor = .black
        self.delegate = self
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
    
    private func didFinishPicking(_ picker: YPImagePicker){
        picker.didFinishPicking { items, _ in
            picker.dismiss(animated: false) {
                guard let selectedImage = items.singlePhoto?.image else { return }
                
                let controller = UploadPostController()
                controller.selectedImage = selectedImage
                controller.delegate = self
                controller.currentUser = self.user
                let vc = UINavigationController(rootViewController: controller)
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false, completion: nil)
            }
        }
    }
}

// MARK: AuthenticationDelegate
extension MainTabController: AuthenticationDelegate {
    func authenticationDidComplete() {      // 인증 완료
        fetchUser()
        self.dismiss(animated: true, completion: nil)
    }
}

// tabbarController가 몇번째 탭에서 호출됫는지 숫자로 알려줌
extension MainTabController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        
        if index == 2 {
            var config = YPImagePickerConfiguration()
            config.library.mediaType = .photo
            config.shouldSaveNewPicturesToAlbum = false
            config.startOnScreen = .library
            config.screens = [.library]
            config.hidesStatusBar = false
            config.hidesBottomBar = false
            config.library.maxNumberOfItems = 1
            
            let picker = YPImagePicker(configuration: config)
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true, completion: nil)
            didFinishPicking(picker)
        }
        return true
    }
}

extension MainTabController: UploadPostControllerDelegate {
    func controllerDidFinishUploadingPost(_ controller: UploadPostController) {
        selectedIndex = 0
        controller.dismiss(animated: true, completion: nil)
        
        guard let feedNav = viewControllers?.first as? UINavigationController else { return }
        guard let feed = feedNav.viewControllers.first as? FeedController else { return }
        feed.handleRefresh()
    }
    
    
}
