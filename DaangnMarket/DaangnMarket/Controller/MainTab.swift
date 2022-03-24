import UIKit

class MainTab: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        tabItem()
    }
    
    private func tabItem(){
        let home = UINavigationController(rootViewController: HomeController())
        let life = UINavigationController(rootViewController: LifeController())
        let near = UINavigationController(rootViewController: NearController())
        let chat = UINavigationController(rootViewController: ChatController())
        let myDaangn = UINavigationController(rootViewController: MyDaangnController(collectionViewLayout: UICollectionViewFlowLayout()))
        
        home.tabBarItem = UITabBarItem(title: "홈", image: UIImage(named: "homeOff"), selectedImage: UIImage(named: "homeOn"))
        life.tabBarItem = UITabBarItem(title: "동네생활", image: UIImage(named: "lifeOff"), selectedImage: UIImage(named: "lifeOn"))
        near.tabBarItem = UITabBarItem(title: "내 근처", image: UIImage(named: "nearOff"), selectedImage: UIImage(named: "nearOn"))
        chat.tabBarItem = UITabBarItem(title: "채팅", image: UIImage(named: "chatOff"), selectedImage: UIImage(named: "chatOn"))
        myDaangn.tabBarItem = UITabBarItem(title: "나의 당근", image: UIImage(named: "myOff"), selectedImage: UIImage(named: "myOn"))
        
        viewControllers = [home, life, near, chat, myDaangn]
        tabBar.tintColor = .black
    }
}
