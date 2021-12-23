import UIKit
import KakaoSDKUser

class friends: UIViewController{
    private func naviView() {
        let titleName = UILabel()
        titleName.text = "친구"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleName)
        
        let search = UIButton()
        search.setImage(UIImage(named: "search"), for: .normal)
        let friendAdd = UIButton()
        friendAdd.setImage(UIImage(named: "friendAdd"), for: .normal)
        let talkMusic = UIButton()
        talkMusic.setImage(UIImage(named: "music"), for: .normal)
        let setting = UIButton()
        setting.setImage(UIImage(named: "setting"), for: .normal)
        let searchBtn = UIBarButtonItem(customView: search)
        let friendAddBtn = UIBarButtonItem(customView: friendAdd)
        let talkMusicBtn = UIBarButtonItem(customView: talkMusic)
        let settingBtn = UIBarButtonItem(customView: setting)
        navigationItem.rightBarButtonItems = [settingBtn, talkMusicBtn, friendAddBtn, searchBtn]
        // rightBarButtonItems 뒤에 s를 안 붙여서 삽질함....
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naviView()
        tableView()
    }
    
}

extension friends: UITableViewDataSource {
    
    private func tableView() {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.frame = view.bounds
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    
    // 테이블 뷰의 한 섹션 당 몇 개의 셀을 넣을 것인지 설정(필수)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    // 테이블 뷰에서 각 Index에 맞는 셀을 추가(필수)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friendcell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let image = UIImage(named: "friendOff")
        let friendImage = UIImageView(image: image)
        friendcell.addSubview(friendImage)
        friendImage.layer.cornerRadius = 100
        friendImage.layer.borderWidth = 1
        friendImage.layer.borderColor = UIColor.gray.cgColor
        friendImage.translatesAutoresizingMaskIntoConstraints = false
        friendImage.leftAnchor.constraint(equalTo: friendcell.leftAnchor, constant: 20).isActive = true
        friendImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        
        let nameLabel = UILabel()
        friendcell.addSubview(nameLabel)
        nameLabel.text = "n"
        nameLabel.font = UIFont.systemFont(ofSize: 12)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leftAnchor.constraint(equalTo: friendImage.rightAnchor, constant: 15).isActive = true
                
        let introLabel = UILabel()
        friendcell.addSubview(introLabel)
        introLabel.text = "i"
        introLabel.font = UIFont.systemFont(ofSize: 10)
        introLabel.textColor = .gray
        introLabel.translatesAutoresizingMaskIntoConstraints = false
        introLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        introLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3).isActive = true
        
        let myCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        let cell = [myCell,friendcell]
        
        return cell[indexPath.row]
    }
    
}
