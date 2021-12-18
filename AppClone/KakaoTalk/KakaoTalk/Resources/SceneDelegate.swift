import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: scene.coordinateSpace.bounds)
        window?.windowScene = scene
        
        // 탭바컨트롤러 객체 생성
        let tabBarController = UITabBarController()
        
        // 네비게이션 객체 생성
        
        // 컨트롤러 5개를 네비게이션컨트롤러로 뷰 객체 생성 
        let friends = UINavigationController(rootViewController: friends())
        let chat = UINavigationController(rootViewController: chat())
        let view = UINavigationController(rootViewController: view())
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
        window?.rootViewController = tabBarController
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

