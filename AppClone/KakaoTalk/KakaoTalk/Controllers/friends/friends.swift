import UIKit
import KakaoSDKUser

class friends: UIViewController, UITableViewDataSource {    // UITableViewDataSource 프로토콜 사용
    // 테이블 뷰의 한 섹션 당 몇 개의 셀을 넣을 것인지 설정(필수)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    // 테이블 뷰에서 각 Index에 맞는 셀을 추가(필수)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: TableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        return cell
    }
    
    
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
    
    func tableViewSet() {
        let tableView: UITableView = {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            return tableView
        }()
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        // 셀 등록하기
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        // 데이터 소스를 self로 지정
        tableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naviView()
        tableViewSet()
    }
    
}
