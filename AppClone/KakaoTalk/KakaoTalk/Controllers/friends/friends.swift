import UIKit

class friends: UIViewController{
    private func naviView() {
        let titleName = UILabel()
        titleName.text = "친구"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleName)
  
//        초기에 버튼을 따로 만들고 그 버튼을 UIBarbutton아이템에 다시 넣고를 반복함 (번거롭게 함)
//        let search = UIButton()
//        search.setImage(UIImage(named: "search"), for: .normal)
//        let searchBtn = UIBarButtonItem(customView: search)
        
        let searchBtn = UIBarButtonItem(image: UIImage(named: "search"), style: .plain, target: self, action: #selector(test))
        let talkMusicBtn = UIBarButtonItem(image: UIImage(named: "music"), style: .plain, target: self, action: #selector(test))
        let friendAddBtn = UIBarButtonItem(image: UIImage(named: "friendAdd"), style: .plain, target: self, action: #selector(friendsAdd))
        let settingBtn = UIBarButtonItem(image: UIImage(named: "setting"), style: .plain, target: self, action: #selector(test))
        
        
        navigationItem.rightBarButtonItems = [settingBtn, talkMusicBtn, friendAddBtn, searchBtn]
        // rightBarButtonItems 뒤에 s를 안 붙여서 삽질함....
    }
    
    @objc func test(){
        print("i")
    }
    
    @objc func friendsAdd(){
        view.backgroundColor = UIColor(white: 0.2, alpha: 0.9)
        navigationController?.pushViewController(addView(), animated: true)
    }
    
    class addView: UIViewController {
        override func viewDidLoad() {
            super.viewDidLoad()
            let subView = UIView()
            view.addSubview(subView)
            subView.backgroundColor = .red
            subView.translatesAutoresizingMaskIntoConstraints = false
            subView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
            subView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        }
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
        return 3
    }
    // 테이블 뷰에서 각 Index에 맞는 셀을 추가(필수)
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        myCell.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        let topImage = UIImage(named: "Faker")
        let myImage = UIImageView(image: topImage)
        myCell.addSubview(myImage)
        myImage.layer.cornerRadius = myImage.bounds.size.width * 0.4
        myImage.clipsToBounds = true
        myImage.translatesAutoresizingMaskIntoConstraints = false
        myImage.leftAnchor.constraint(equalTo: myCell.leftAnchor, constant: 20).isActive = true
        myImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        myImage.centerYAnchor.constraint(equalTo: myCell.centerYAnchor).isActive = true
        
        let myLabel = UILabel()
        myCell.addSubview(myLabel)
        myLabel.text = "Faker"
        myLabel.font = UIFont.systemFont(ofSize: 20)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.topAnchor.constraint(equalTo: myImage.topAnchor, constant: 10).isActive = true
        myLabel.leftAnchor.constraint(equalTo: myImage.rightAnchor, constant: 15).isActive = true
                
        let myIntroLabel = UILabel()
        myCell.addSubview(myIntroLabel)
        myIntroLabel.text = "탑은 죽어도 이득"
        myIntroLabel.font = UIFont.systemFont(ofSize: 14)
        myIntroLabel.textColor = .gray
        myIntroLabel.translatesAutoresizingMaskIntoConstraints = false
        myIntroLabel.leftAnchor.constraint(equalTo: myLabel.leftAnchor).isActive = true
        myIntroLabel.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 3).isActive = true
        
        
        let countCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        countCell.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let botView = UIView()
        countCell.addSubview(botView)
        botView.backgroundColor = .gray
        botView.translatesAutoresizingMaskIntoConstraints = false
        botView.topAnchor.constraint(equalTo: countCell.topAnchor, constant: 5).isActive = true
        botView.centerXAnchor.constraint(equalTo: countCell.centerXAnchor).isActive = true
        botView.widthAnchor.constraint(equalTo: countCell.widthAnchor, multiplier: 0.9).isActive = true
        botView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        let countLabel = UILabel()
        countCell.addSubview(countLabel)
        countLabel.text = "친구 "
        countLabel.textColor = .gray
        countLabel.font = UIFont.systemFont(ofSize: 14)
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.leftAnchor.constraint(equalTo: botView.leftAnchor).isActive = true
        countLabel.topAnchor.constraint(equalTo: botView.bottomAnchor, constant: 10).isActive = true
        
        
        
        let friendcell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        friendcell.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        let image = UIImage(named: "Faker")
        let friendImage = UIImageView(image: image)
        friendcell.addSubview(friendImage)
        friendImage.layer.cornerRadius = myImage.bounds.size.width * 0.4
        friendImage.clipsToBounds = true
        friendImage.translatesAutoresizingMaskIntoConstraints = false
        friendImage.leftAnchor.constraint(equalTo: friendcell.leftAnchor, constant: 20).isActive = true
        friendImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        friendImage.centerYAnchor.constraint(equalTo: friendcell.centerYAnchor).isActive = true
        
        let nameLabel = UILabel()
        friendcell.addSubview(nameLabel)
        nameLabel.text = "name"
        nameLabel.font = UIFont.systemFont(ofSize: 22)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: friendImage.topAnchor, constant: 10).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: friendImage.rightAnchor, constant: 15).isActive = true
        
        let introLabel = UILabel()
        friendcell.addSubview(introLabel)
        introLabel.text = "intro"
        introLabel.font = UIFont.systemFont(ofSize: 14)
        introLabel.textColor = .gray
        introLabel.translatesAutoresizingMaskIntoConstraints = false
        introLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        introLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3).isActive = true
        
        
        let cell = [myCell,countCell,friendcell]
        
        return cell[indexPath.row]
    }
    
}
