import UIKit

class shopping: UIViewController, UITableViewDataSource {
    
    private func naviView() {
        let titleName = UILabel()
        titleName.text = "쇼핑"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleName)
        let qr = UIButton()
        qr.setImage(UIImage(named: "qr"), for: .normal)
        let music = UIButton()
        music.setImage(UIImage(named: "music"), for: .normal)
        let set = UIButton()
        set.setImage(UIImage(named: "setting"), for: .normal)
        
        let qrBtn = UIBarButtonItem(customView: qr)
        let musicBtn = UIBarButtonItem(customView: music)
        let setBtn = UIBarButtonItem(customView: set)
        navigationItem.rightBarButtonItems = [qrBtn, musicBtn, setBtn]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naviView()
        tableView()
    }
}

extension shopping : UITableViewDelegate{
    
    private func tableView() {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.frame = view.bounds
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let topMenu = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        topMenu.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let giftBtn = UIButton()
        topMenu.addSubview(giftBtn)
        giftBtn.setTitle("선물하기", for: .normal)
        giftBtn.setImage(UIImage(named: "gift"), for: .normal)
        giftBtn.translatesAutoresizingMaskIntoConstraints = false
        giftBtn.widthAnchor.constraint(equalTo: topMenu.widthAnchor, multiplier: 0.2).isActive = true
        giftBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true

        let shopBtn = UIButton()
        topMenu.addSubview(shopBtn)
        shopBtn.setTitle("쇼핑하기", for: .normal)
        shopBtn.setImage(UIImage(named: "gift"), for: .normal)
        shopBtn.translatesAutoresizingMaskIntoConstraints = false
        shopBtn.widthAnchor.constraint(equalTo: topMenu.widthAnchor, multiplier: 0.2).isActive = true
        shopBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        shopBtn.leftAnchor.constraint(equalTo: giftBtn.rightAnchor).isActive = true
        
        let makerBtn = UIButton()
        topMenu.addSubview(makerBtn)
        makerBtn.setTitle("메이커스", for: .normal)
        makerBtn.setImage(UIImage(named: "gift"), for: .normal)
        makerBtn.translatesAutoresizingMaskIntoConstraints = false
        makerBtn.widthAnchor.constraint(equalTo: topMenu.widthAnchor, multiplier: 0.2).isActive = true
        makerBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        makerBtn.leftAnchor.constraint(equalTo: shopBtn.rightAnchor).isActive = true
        
        let friBtn = UIButton()
        topMenu.addSubview(friBtn)
        friBtn.setTitle("프렌즈", for: .normal)
        friBtn.setImage(UIImage(named: "gift"), for: .normal)
        friBtn.translatesAutoresizingMaskIntoConstraints = false
        friBtn.widthAnchor.constraint(equalTo: topMenu.widthAnchor, multiplier: 0.2).isActive = true
        friBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        friBtn.leftAnchor.constraint(equalTo: makerBtn.rightAnchor).isActive = true
        
        let liveBtn = UIButton()
        topMenu.addSubview(liveBtn)
        liveBtn.setTitle("쇼핑라이브", for: .normal)
        liveBtn.setImage(UIImage(named: "gift"), for: .normal)
        liveBtn.translatesAutoresizingMaskIntoConstraints = false
        liveBtn.widthAnchor.constraint(equalTo: topMenu.widthAnchor, multiplier: 0.2).isActive = true
        liveBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        liveBtn.leftAnchor.constraint(equalTo: friBtn.rightAnchor).isActive = true
        
        
        let cell = [topMenu]
        return cell[indexPath.row]
    }
    
}
