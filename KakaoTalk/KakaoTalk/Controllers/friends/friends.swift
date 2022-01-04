import UIKit
import Alamofire

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
        return 10
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
                
        let image = UIImage(named: "friend_0")
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
        nameLabel.text = "바드"
        nameLabel.font = UIFont.systemFont(ofSize: 22)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: friendImage.topAnchor, constant: 10).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: friendImage.rightAnchor, constant: 15).isActive = true
        
        let introLabel = UILabel()
        friendcell.addSubview(introLabel)
        introLabel.text = ""
        introLabel.font = UIFont.systemFont(ofSize: 14)
        introLabel.textColor = .gray
        introLabel.translatesAutoresizingMaskIntoConstraints = false
        introLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        introLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3).isActive = true
        
        let friendcell1 = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        friendcell1.heightAnchor.constraint(equalToConstant: 70).isActive = true
                
        let image1 = UIImage(named: "friend_1")
        let friendImage1 = UIImageView(image: image1)
        friendcell1.addSubview(friendImage1)
        friendImage1.layer.cornerRadius = myImage.bounds.size.width * 0.4
        friendImage1.clipsToBounds = true
        friendImage1.translatesAutoresizingMaskIntoConstraints = false
        friendImage1.leftAnchor.constraint(equalTo: friendcell1.leftAnchor, constant: 20).isActive = true
        friendImage1.widthAnchor.constraint(equalToConstant: 60).isActive = true
        friendImage1.centerYAnchor.constraint(equalTo: friendcell1.centerYAnchor).isActive = true
        
        let nameLabel1 = UILabel()
        friendcell1.addSubview(nameLabel1)
        nameLabel1.text = "리 신"
        nameLabel1.font = UIFont.systemFont(ofSize: 22)
        nameLabel1.translatesAutoresizingMaskIntoConstraints = false
        nameLabel1.topAnchor.constraint(equalTo: friendImage1.topAnchor, constant: 10).isActive = true
        nameLabel1.leftAnchor.constraint(equalTo: friendImage1.rightAnchor, constant: 15).isActive = true
        
        let introLabel1 = UILabel()
        friendcell1.addSubview(introLabel1)
        introLabel1.text = "어디로 가야하오"
        introLabel1.font = UIFont.systemFont(ofSize: 14)
        introLabel1.textColor = .gray
        introLabel1.translatesAutoresizingMaskIntoConstraints = false
        introLabel1.leftAnchor.constraint(equalTo: nameLabel1.leftAnchor).isActive = true
        introLabel1.topAnchor.constraint(equalTo: nameLabel1.bottomAnchor, constant: 3).isActive = true
        
        let friendcell2 = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        friendcell2.heightAnchor.constraint(equalToConstant: 70).isActive = true
                
        let image2 = UIImage(named: "friend_2")
        let friendImage2 = UIImageView(image: image2)
        friendcell2.addSubview(friendImage2)
        friendImage2.layer.cornerRadius = myImage.bounds.size.width * 0.4
        friendImage2.clipsToBounds = true
        friendImage2.translatesAutoresizingMaskIntoConstraints = false
        friendImage2.leftAnchor.constraint(equalTo: friendcell2.leftAnchor, constant: 20).isActive = true
        friendImage2.widthAnchor.constraint(equalToConstant: 60).isActive = true
        friendImage2.centerYAnchor.constraint(equalTo: friendcell2.centerYAnchor).isActive = true
        
        let nameLabel2 = UILabel()
        friendcell2.addSubview(nameLabel2)
        nameLabel2.text = "루시안"
        nameLabel2.font = UIFont.systemFont(ofSize: 22)
        nameLabel2.translatesAutoresizingMaskIntoConstraints = false
        nameLabel2.topAnchor.constraint(equalTo: friendImage2.topAnchor, constant: 10).isActive = true
        nameLabel2.leftAnchor.constraint(equalTo: friendImage2.rightAnchor, constant: 15).isActive = true
        
        let introLabel2 = UILabel()
        friendcell2.addSubview(introLabel2)
        introLabel2.text = "세나의 복수닷!"
        introLabel2.font = UIFont.systemFont(ofSize: 14)
        introLabel2.textColor = .gray
        introLabel2.translatesAutoresizingMaskIntoConstraints = false
        introLabel2.leftAnchor.constraint(equalTo: nameLabel2.leftAnchor).isActive = true
        introLabel2.topAnchor.constraint(equalTo: nameLabel2.bottomAnchor, constant: 3).isActive = true
        
        
        let friendcell3 = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        friendcell3.heightAnchor.constraint(equalToConstant: 70).isActive = true
                
        let image3 = UIImage(named: "friend_3")
        let friendImage3 = UIImageView(image: image3)
        friendcell3.addSubview(friendImage3)
        friendImage3.layer.cornerRadius = myImage.bounds.size.width * 0.4
        friendImage3.clipsToBounds = true
        friendImage3.translatesAutoresizingMaskIntoConstraints = false
        friendImage3.leftAnchor.constraint(equalTo: friendcell3.leftAnchor, constant: 20).isActive = true
        friendImage3.widthAnchor.constraint(equalToConstant: 60).isActive = true
        friendImage3.centerYAnchor.constraint(equalTo: friendcell3.centerYAnchor).isActive = true
        
        let nameLabel3 = UILabel()
        friendcell3.addSubview(nameLabel3)
        nameLabel3.text = "미스 포츈"
        nameLabel3.font = UIFont.systemFont(ofSize: 22)
        nameLabel3.translatesAutoresizingMaskIntoConstraints = false
        nameLabel3.topAnchor.constraint(equalTo: friendImage3.topAnchor, constant: 10).isActive = true
        nameLabel3.leftAnchor.constraint(equalTo: friendImage3.rightAnchor, constant: 15).isActive = true
        
        let introLabel3 = UILabel()
        friendcell3.addSubview(introLabel3)
        introLabel3.text = "행운은 멍청이들을 싫어하지~"
        introLabel3.font = UIFont.systemFont(ofSize: 14)
        introLabel3.textColor = .gray
        introLabel3.translatesAutoresizingMaskIntoConstraints = false
        introLabel3.leftAnchor.constraint(equalTo: nameLabel3.leftAnchor).isActive = true
        introLabel3.topAnchor.constraint(equalTo: nameLabel3.bottomAnchor, constant: 3).isActive = true
        
        let friendcell4 = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        friendcell4.heightAnchor.constraint(equalToConstant: 70).isActive = true
                
        let image4 = UIImage(named: "friend_4")
        let friendImage4 = UIImageView(image: image4)
        friendcell4.addSubview(friendImage4)
        friendImage4.layer.cornerRadius = myImage.bounds.size.width * 0.4
        friendImage4.clipsToBounds = true
        friendImage4.translatesAutoresizingMaskIntoConstraints = false
        friendImage4.leftAnchor.constraint(equalTo: friendcell4.leftAnchor, constant: 20).isActive = true
        friendImage4.widthAnchor.constraint(equalToConstant: 60).isActive = true
        friendImage4.centerYAnchor.constraint(equalTo: friendcell4.centerYAnchor).isActive = true
        
        let nameLabel4 = UILabel()
        friendcell4.addSubview(nameLabel4)
        nameLabel4.text = "카이사"
        nameLabel4.font = UIFont.systemFont(ofSize: 22)
        nameLabel4.translatesAutoresizingMaskIntoConstraints = false
        nameLabel4.topAnchor.constraint(equalTo: friendImage4.topAnchor, constant: 10).isActive = true
        nameLabel4.leftAnchor.constraint(equalTo: friendImage4.rightAnchor, constant: 15).isActive = true
        
        let introLabel4 = UILabel()
        friendcell4.addSubview(introLabel4)
        introLabel4.text = "하난 보냈고"
        introLabel4.font = UIFont.systemFont(ofSize: 14)
        introLabel4.textColor = .gray
        introLabel4.translatesAutoresizingMaskIntoConstraints = false
        introLabel4.leftAnchor.constraint(equalTo: nameLabel4.leftAnchor).isActive = true
        introLabel4.topAnchor.constraint(equalTo: nameLabel4.bottomAnchor, constant: 3).isActive = true
        
        let friendcell5 = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        friendcell5.heightAnchor.constraint(equalToConstant: 70).isActive = true
                
        let image5 = UIImage(named: "friend_5")
        let friendImage5 = UIImageView(image: image5)
        friendcell5.addSubview(friendImage5)
        friendImage5.layer.cornerRadius = myImage.bounds.size.width * 0.4
        friendImage5.clipsToBounds = true
        friendImage5.translatesAutoresizingMaskIntoConstraints = false
        friendImage5.leftAnchor.constraint(equalTo: friendcell5.leftAnchor, constant: 20).isActive = true
        friendImage5.widthAnchor.constraint(equalToConstant: 60).isActive = true
        friendImage5.centerYAnchor.constraint(equalTo: friendcell5.centerYAnchor).isActive = true
        
        let nameLabel5 = UILabel()
        friendcell5.addSubview(nameLabel5)
        nameLabel5.text = "앨리스"
        nameLabel5.font = UIFont.systemFont(ofSize: 22)
        nameLabel5.translatesAutoresizingMaskIntoConstraints = false
        nameLabel5.topAnchor.constraint(equalTo: friendImage5.topAnchor, constant: 10).isActive = true
        nameLabel5.leftAnchor.constraint(equalTo: friendImage5.rightAnchor, constant: 15).isActive = true
        
        let introLabel5 = UILabel()
        friendcell5.addSubview(introLabel5)
        introLabel5.text = "거미줄에선 거미만 안전하지"
        introLabel5.font = UIFont.systemFont(ofSize: 14)
        introLabel5.textColor = .gray
        introLabel5.translatesAutoresizingMaskIntoConstraints = false
        introLabel5.leftAnchor.constraint(equalTo: nameLabel5.leftAnchor).isActive = true
        introLabel5.topAnchor.constraint(equalTo: nameLabel5.bottomAnchor, constant: 3).isActive = true
        
        let friendcell6 = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        friendcell6.heightAnchor.constraint(equalToConstant: 70).isActive = true
                
        let image6 = UIImage(named: "friend_6")
        let friendImage6 = UIImageView(image: image6)
        friendcell6.addSubview(friendImage6)
        friendImage6.layer.cornerRadius = myImage.bounds.size.width * 0.4
        friendImage6.clipsToBounds = true
        friendImage6.translatesAutoresizingMaskIntoConstraints = false
        friendImage6.leftAnchor.constraint(equalTo: friendcell6.leftAnchor, constant: 20).isActive = true
        friendImage6.widthAnchor.constraint(equalToConstant: 60).isActive = true
        friendImage6.centerYAnchor.constraint(equalTo: friendcell6.centerYAnchor).isActive = true
        
        let nameLabel6 = UILabel()
        friendcell6.addSubview(nameLabel6)
        nameLabel6.text = "이즈리얼"
        nameLabel6.font = UIFont.systemFont(ofSize: 22)
        nameLabel6.translatesAutoresizingMaskIntoConstraints = false
        nameLabel6.topAnchor.constraint(equalTo: friendImage6.topAnchor, constant: 10).isActive = true
        nameLabel6.leftAnchor.constraint(equalTo: friendImage6.rightAnchor, constant: 15).isActive = true
        
        let introLabel6 = UILabel()
        friendcell6.addSubview(introLabel6)
        introLabel6.text = "이래도 안 넘어어올래~"
        introLabel6.font = UIFont.systemFont(ofSize: 14)
        introLabel6.textColor = .gray
        introLabel6.translatesAutoresizingMaskIntoConstraints = false
        introLabel6.leftAnchor.constraint(equalTo: nameLabel6.leftAnchor).isActive = true
        introLabel6.topAnchor.constraint(equalTo: nameLabel6.bottomAnchor, constant: 3).isActive = true
        
        let friendcell7 = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        friendcell7.heightAnchor.constraint(equalToConstant: 70).isActive = true
                
        let image7 = UIImage(named: "friend_7")
        let friendImage7 = UIImageView(image: image7)
        friendcell7.addSubview(friendImage7)
        friendImage7.layer.cornerRadius = myImage.bounds.size.width * 0.4
        friendImage7.clipsToBounds = true
        friendImage7.translatesAutoresizingMaskIntoConstraints = false
        friendImage7.leftAnchor.constraint(equalTo: friendcell7.leftAnchor, constant: 20).isActive = true
        friendImage7.widthAnchor.constraint(equalToConstant: 60).isActive = true
        friendImage7.centerYAnchor.constraint(equalTo: friendcell7.centerYAnchor).isActive = true
        
        let nameLabel7 = UILabel()
        friendcell7.addSubview(nameLabel7)
        nameLabel7.text = "에코"
        nameLabel7.font = UIFont.systemFont(ofSize: 22)
        nameLabel7.translatesAutoresizingMaskIntoConstraints = false
        nameLabel7.topAnchor.constraint(equalTo: friendImage7.topAnchor, constant: 10).isActive = true
        nameLabel7.leftAnchor.constraint(equalTo: friendImage7.rightAnchor, constant: 15).isActive = true
        
        let introLabel7 = UILabel()
        friendcell7.addSubview(introLabel7)
        introLabel7.text = "이리 오실까!"
        introLabel7.font = UIFont.systemFont(ofSize: 14)
        introLabel7.textColor = .gray
        introLabel7.translatesAutoresizingMaskIntoConstraints = false
        introLabel7.leftAnchor.constraint(equalTo: nameLabel7.leftAnchor).isActive = true
        introLabel7.topAnchor.constraint(equalTo: nameLabel7.bottomAnchor, constant: 3).isActive = true
        
        
        let cell = [myCell,countCell,friendcell,friendcell1,friendcell2,friendcell3,friendcell4,friendcell5,friendcell6,friendcell7]
        
        return cell[indexPath.row]
    }
    
}
