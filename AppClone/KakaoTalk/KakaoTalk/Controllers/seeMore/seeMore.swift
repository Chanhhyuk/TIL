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
        
    override func viewDidLoad() {
        super.viewDidLoad()
        naviView()
        tableView()
    }
    
}

extension seeMore: UITableViewDataSource {
    
    private func tableView() {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.frame = view.bounds
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
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
        mailBtn.backgroundColor = .green
        mailBtn.setTitle("메일", for: .normal)
        mailBtn.titleLabel?.font = .boldSystemFont(ofSize: 10)
        mailBtn.setImage(UIImage(named: "music"), for: .normal)
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
        
        let kakaoConBtn = UIButton()
        kakaoConBtn.setTitle("카카오콘", for: .normal)
        moreMenu.addSubview(kakaoConBtn)
        kakaoConBtn.translatesAutoresizingMaskIntoConstraints = false
        kakaoConBtn.leftAnchor.constraint(equalTo: deskBtn.rightAnchor).isActive = true
        kakaoConBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        kakaoConBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let makersBtn = UIButton()
        makersBtn.setTitle("메이커스", for: .normal)
        moreMenu.addSubview(makersBtn)
        makersBtn.translatesAutoresizingMaskIntoConstraints = false
        makersBtn.topAnchor.constraint(equalTo: mailBtn.bottomAnchor).isActive = true
        makersBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        makersBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let giftBtn = UIButton()
        giftBtn.setTitle("선물하기", for: .normal)
        moreMenu.addSubview(giftBtn)
        giftBtn.translatesAutoresizingMaskIntoConstraints = false
        giftBtn.topAnchor.constraint(equalTo: mailBtn.bottomAnchor).isActive = true
        giftBtn.leftAnchor.constraint(equalTo: makersBtn.rightAnchor).isActive = true
        giftBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        giftBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let emojiBtn = UIButton()
        emojiBtn.setTitle("이모티콘", for: .normal)
        moreMenu.addSubview(emojiBtn)
        emojiBtn.translatesAutoresizingMaskIntoConstraints = false
        emojiBtn.topAnchor.constraint(equalTo: mailBtn.bottomAnchor).isActive = true
        emojiBtn.leftAnchor.constraint(equalTo: giftBtn.rightAnchor).isActive = true
        emojiBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        emojiBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let friBtn = UIButton()
        friBtn.setTitle("프렌즈", for: .normal)
        moreMenu.addSubview(friBtn)
        friBtn.translatesAutoresizingMaskIntoConstraints = false
        friBtn.topAnchor.constraint(equalTo: mailBtn.bottomAnchor).isActive = true
        friBtn.leftAnchor.constraint(equalTo: emojiBtn.rightAnchor).isActive = true
        friBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        friBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let shopBtn = UIButton()
        shopBtn.setTitle("쇼핑하기", for: .normal)
        moreMenu.addSubview(shopBtn)
        shopBtn.translatesAutoresizingMaskIntoConstraints = false
        shopBtn.topAnchor.constraint(equalTo: makersBtn.bottomAnchor).isActive = true
        shopBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        shopBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let fashionBtn = UIButton()
        fashionBtn.setTitle("쇼핑하기", for: .normal)
        moreMenu.addSubview(fashionBtn)
        fashionBtn.translatesAutoresizingMaskIntoConstraints = false
        fashionBtn.topAnchor.constraint(equalTo: makersBtn.bottomAnchor).isActive = true
        fashionBtn.leftAnchor.constraint(equalTo: shopBtn.rightAnchor).isActive = true
        fashionBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        fashionBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let foodBtn = UIButton()
        foodBtn.setTitle("주문하기", for: .normal)
        moreMenu.addSubview(foodBtn)
        foodBtn.translatesAutoresizingMaskIntoConstraints = false
        foodBtn.topAnchor.constraint(equalTo: makersBtn.bottomAnchor).isActive = true
        foodBtn.leftAnchor.constraint(equalTo: fashionBtn.rightAnchor).isActive = true
        foodBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        foodBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let ticketBtn = UIButton()
        ticketBtn.setTitle("티켓", for: .normal)
        moreMenu.addSubview(ticketBtn)
        ticketBtn.translatesAutoresizingMaskIntoConstraints = false
        ticketBtn.topAnchor.constraint(equalTo: makersBtn.bottomAnchor).isActive = true
        ticketBtn.leftAnchor.constraint(equalTo: foodBtn.rightAnchor).isActive = true
        ticketBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        ticketBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let gameBtn = UIButton()
        gameBtn.setTitle("게임", for: .normal)
        moreMenu.addSubview(gameBtn)
        gameBtn.translatesAutoresizingMaskIntoConstraints = false
        gameBtn.topAnchor.constraint(equalTo: shopBtn.bottomAnchor).isActive = true
        gameBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        gameBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let onBtn = UIButton()
        onBtn.setTitle("구독 ON", for: .normal)
        moreMenu.addSubview(onBtn)
        onBtn.translatesAutoresizingMaskIntoConstraints = false
        onBtn.topAnchor.constraint(equalTo: shopBtn.bottomAnchor).isActive = true
        onBtn.leftAnchor.constraint(equalTo: gameBtn.rightAnchor).isActive = true
        onBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        onBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let eungBtn = UIButton()
        eungBtn.setTitle("응", for: .normal)
        moreMenu.addSubview(eungBtn)
        eungBtn.translatesAutoresizingMaskIntoConstraints = false
        eungBtn.topAnchor.constraint(equalTo: shopBtn.bottomAnchor).isActive = true
        eungBtn.leftAnchor.constraint(equalTo: onBtn.rightAnchor).isActive = true
        eungBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        eungBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let menuBtn = UIButton()
        menuBtn.setTitle("전체서비스", for: .normal)
        moreMenu.addSubview(menuBtn)
        menuBtn.translatesAutoresizingMaskIntoConstraints = false
        menuBtn.topAnchor.constraint(equalTo: shopBtn.bottomAnchor).isActive = true
        menuBtn.leftAnchor.constraint(equalTo: eungBtn.rightAnchor).isActive = true
        menuBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        menuBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        let ad = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        ad.backgroundColor = .purple
        ad.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        let cell = [wallet,moreMenu,ad]
        
        return cell[indexPath.row]
    }
}
