import UIKit

class seeMore: UIViewController {
    
    private func naviView() {
        let titleName = UILabel()
        titleName.text = "더보기"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleName)
        
        let search = UIButton()
        search.setImage(UIImage(named: "search"), for: .normal)
        let qr = UIButton()
        qr.setImage(UIImage(named: "qr"), for: .normal)
        let talkMusic = UIButton()
        talkMusic.setImage(UIImage(named: "music"), for: .normal)
        let setting = UIButton()
        setting.setImage(UIImage(named: "setting"), for: .normal)
        setting.addTarget(self, action: #selector(setMove(_:)), for: .touchUpInside)
        
        let searchBtn = UIBarButtonItem(customView: search)
        let qrBtn = UIBarButtonItem(customView: qr)
        let talkMusicBtn = UIBarButtonItem(customView: talkMusic)
        let settingBtn = UIBarButtonItem(customView: setting)
        navigationItem.rightBarButtonItems = [settingBtn, talkMusicBtn, qrBtn, searchBtn]
        // rightBarButtonItems 뒤에 s를 안 붙여서 삽질함....
    }
    
    @objc func setMove(_: UIButton) {
        navigationController?.pushViewController(setting(), animated: true)
    }
    
    private func tableView() {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.frame = view.bounds
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        naviView()
        tableView()
    }
    
}

extension seeMore: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3           // 하드코딩 되어있음
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let wallet = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        wallet.backgroundColor = UIColor(red: 249, green: 224, blue: 0, alpha: 1)
        wallet.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        let walletBtn = UIButton()
        walletBtn.setTitle("지갑 >", for: .normal)
        wallet.addSubview(walletBtn)
        walletBtn.translatesAutoresizingMaskIntoConstraints = false
        walletBtn.topAnchor.constraint(equalTo: wallet.topAnchor, constant: 20).isActive = true
        walletBtn.leftAnchor.constraint(equalTo: wallet.leftAnchor, constant: 30).isActive = true
        
        let qrBtn = UIButton()
        qrBtn.setTitle("QR 체크인", for:.normal)
        wallet.addSubview(qrBtn)
        qrBtn.translatesAutoresizingMaskIntoConstraints = false
        qrBtn.topAnchor.constraint(equalTo: wallet.topAnchor, constant: 20).isActive = true
        qrBtn.rightAnchor.constraint(equalTo: wallet.rightAnchor, constant: -30).isActive = true
        
        let certBtn = UIButton()
        certBtn.setTitle("인증서", for: .normal)
        wallet.addSubview(certBtn)
        certBtn.translatesAutoresizingMaskIntoConstraints = false
        certBtn.topAnchor.constraint(equalTo: wallet.topAnchor, constant: 20).isActive = true
        certBtn.rightAnchor.constraint(equalTo: qrBtn.rightAnchor , constant: -100).isActive = true
        
        let remiBtn = UIButton()
        remiBtn.setTitle("송금", for: .normal)
        wallet.addSubview(remiBtn)
        remiBtn.translatesAutoresizingMaskIntoConstraints = false
        remiBtn.bottomAnchor.constraint(equalTo: wallet.bottomAnchor, constant: -30).isActive = true
        remiBtn.leftAnchor.constraint(equalTo: walletBtn.leftAnchor, constant: -10).isActive = true
        remiBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        let payment = UIButton()
        payment.setTitle("결제", for: .normal)
        wallet.addSubview(payment)
        payment.translatesAutoresizingMaskIntoConstraints = false
        payment.bottomAnchor.constraint(equalTo: remiBtn.bottomAnchor).isActive = true
        payment.leftAnchor.constraint(equalTo: remiBtn.rightAnchor, constant: 10).isActive = true
        payment.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        let asset = UIButton()
        asset.setTitle("자산", for: .normal)
        wallet.addSubview(asset)
        asset.translatesAutoresizingMaskIntoConstraints = false
        asset.bottomAnchor.constraint(equalTo: remiBtn.bottomAnchor).isActive = true
        asset.leftAnchor.constraint(equalTo: payment.rightAnchor, constant: 10).isActive = true
        asset.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        let buyHis = UIButton()
        buyHis.setTitle("구매내역", for: .normal)
        wallet.addSubview(buyHis)
        buyHis.translatesAutoresizingMaskIntoConstraints = false
        buyHis.bottomAnchor.constraint(equalTo: remiBtn.bottomAnchor).isActive = true
        buyHis.leftAnchor.constraint(equalTo: wallet.rightAnchor, constant: -150).isActive = true
        buyHis.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        
        
        let moreMenu = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        moreMenu.heightAnchor.constraint(equalToConstant: 400).isActive = true

        let mailBtn = UIButton()
        mailBtn.setTitle("메일", for: .normal)
        moreMenu.addSubview(mailBtn)
        mailBtn.translatesAutoresizingMaskIntoConstraints = false
        mailBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        mailBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let dateBtn = UIButton()
        dateBtn.setTitle("캘린더", for: .normal)
        moreMenu.addSubview(dateBtn)
        dateBtn.translatesAutoresizingMaskIntoConstraints = false
        dateBtn.leftAnchor.constraint(equalTo: mailBtn.rightAnchor).isActive = true
        dateBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        dateBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true

        let deskBtn = UIButton()
        deskBtn.setTitle("서랍", for: .normal)
        moreMenu.addSubview(deskBtn)
        deskBtn.translatesAutoresizingMaskIntoConstraints = false
        deskBtn.leftAnchor.constraint(equalTo: dateBtn.rightAnchor).isActive = true
        deskBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        deskBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let emojiBtn = UIButton()
        emojiBtn.setTitle("카카오콘", for: .normal)
        moreMenu.addSubview(emojiBtn)
        emojiBtn.translatesAutoresizingMaskIntoConstraints = false
        emojiBtn.leftAnchor.constraint(equalTo: deskBtn.rightAnchor).isActive = true
        emojiBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        emojiBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let makersBtn = UIButton()
        makersBtn.setTitle("메이커스", for: .normal)
        moreMenu.addSubview(makersBtn)
        makersBtn.backgroundColor = .red
        makersBtn.translatesAutoresizingMaskIntoConstraints = false
        makersBtn.topAnchor.constraint(equalTo: mailBtn.bottomAnchor).isActive = true
        makersBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        makersBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        
        
        
        let ad = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        ad.backgroundColor = .purple
        ad.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        let cell = [wallet,moreMenu,ad]
        
        return cell[indexPath.row]
    }
}
