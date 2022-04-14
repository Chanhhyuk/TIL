import UIKit
import Firebase
import YPImagePicker // 이미지 라이브러리


// UICollectionViewController UITableViewController로 상속받으면 이미 DataSource, Delegate 프로토콜을 준수한다 따로선언해줄 필요가 없다
class MainTabController: UITabBarController {
    
    var user: User? {
        didSet{     // didSet: 값이 변경되기 직전을 감지 한다
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
        // API 폴더에 UserService 구조체에 fetchUser 구조체를 사용
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
    
    // UploadPostController에서 shere를 누를 때 실행. 포스트 게시
    private func didFinishPicking(_ picker: YPImagePicker){
        picker.didFinishPicking { items, _ in       // error는 없으므로 _ 공백
            picker.dismiss(animated: false) {
                guard let selectedImage = items.singlePhoto?.image else { return }  // UploadController에 있는 didSet 선택된 이미지를 전달
                
                let controller = UploadPostController()
                controller.selectedImage = selectedImage    
                controller.delegate = self          // UploadController에 만든 weak var delegate 사용, 맨 아래 protocol에 따른 delegate 사용
                controller.currentUser = self.user
                let vc = UINavigationController(rootViewController: controller)
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: false, completion: nil)
            }
        }
    }
    
    
    private func tabController(withUser user: User){
//        let layout = UICollectionViewLayout()     // 많이 하는 실수 에러도 안남
        let layout = UICollectionViewFlowLayout()   // 직접적으로 적어줘도 됨
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
        tabBar.tintColor = .black
        self.delegate = self        // UploadPostControllerDelegate를 사용하기 위해
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

// MARK: AuthenticationDelegate
extension MainTabController: AuthenticationDelegate {
    func authenticationDidComplete() {      // 인증 완료
        fetchUser()
        self.dismiss(animated: true, completion: nil)
    }
}


extension MainTabController: UITabBarControllerDelegate {
    // tabbarController가 몇번째 탭에서 호출됫는지 숫자로 알려줌
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = viewControllers?.firstIndex(of: viewController)
        
        if index == 2 { // tabBar중 2번째 index가 선택 되었을 때
            var config = YPImagePickerConfiguration()
            config.library.mediaType = .photo       // 유형 사진
            config.shouldSaveNewPicturesToAlbum = false // 편집한 사진을 새로 저장하지 않는다.
            config.startOnScreen = .library
            config.screens = [.library]
            config.hidesStatusBar = false       // 상태바 숨기지 않는다.
            config.hidesBottomBar = false       // 하단바 숨기지 않는다.
            config.library.maxNumberOfItems = 1 // 라이브러리 최대 항복수 1개
            
            let picker = YPImagePicker(configuration: config)
            picker.modalPresentationStyle = .fullScreen
            present(picker, animated: true, completion: nil)
            didFinishPicking(picker)
        }
        return true
    }
}

// PostController에서 게시글을 share하면
extension MainTabController: UploadPostControllerDelegate {
    // 함수를 호출할 때 PostController의 인스턴스에서 전달?
    // 이 기능을 실행할 때마다 PostController는 닫을 것
    func controllerDidFinishUploadingPost(_ controller: UploadPostController) {
        selectedIndex = 0       // 탭바 0번째로 이동(MainController)
        controller.dismiss(animated: true, completion: nil)

        guard let feedNav = viewControllers?.first as? UINavigationController else { return }
        guard let feed = feedNav.viewControllers.first as? FeedController else { return }
        feed.handleRefresh()
    }
}
