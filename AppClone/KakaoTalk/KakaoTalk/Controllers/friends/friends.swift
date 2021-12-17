import UIKit

class friends: UIViewController {
    
    func naviView() {
        let titleName = UILabel()
        titleName.text = "친구"
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: titleName)
        
        let search = UIButton()
        search.setImage(UIImage(named: "friendOff"), for: .normal)
        let friendAdd = UIButton()
        friendAdd.setImage(UIImage(named: "friendOff"), for: .normal)
        let talkMusic = UIButton()
        talkMusic.setImage(UIImage(named: "friendOff"), for: .normal)
        let setting = UIButton()
        setting.setImage(UIImage(named: "friendOff"), for: .normal)
        
        let stackView = UIStackView(arrangedSubviews: [titleName, search, friendAdd, talkMusic, setting])
        stackView.axis = .horizontal
        
        navigationItem.titleView = stackView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naviView()
    }
}
