import UIKit

class seeMore: UIViewController {
    
    private func naviView() {
        let titleName = UILabel()
        titleName.text = "더보기"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleName)
        
        let searchBtn = UIBarButtonItem(image: UIImage(named: "search"), style:  .plain, target: self, action: nil)
        let qrBtn = UIBarButtonItem(image: UIImage(named: "qr"), style: .plain, target: self, action: nil)
        let talkMusicBtn = UIBarButtonItem(image: UIImage(named: "music"), style: .plain, target: self, action: nil)
        let settingBtn = UIBarButtonItem(image: UIImage(named: "setting"), style: .plain, target: self, action: #selector(setMove))
        navigationItem.rightBarButtonItems = [settingBtn, talkMusicBtn, qrBtn, searchBtn]
        // rightBarButtonItems 뒤에 s를 안 붙여서 삽질함....
    }
    
    @objc func setMove() {
        navigationController?.pushViewController(setting(), animated: false)
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        naviView()
        tableView()
        navigationItem.backButtonTitle = "설정"
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
        moreMenu.addSubview(mailBtn)
        mailBtn.setTitle("메일", for: .normal)
        
        mailBtn.titleLabel?.font = UIFont(name: "BMHANNAAir", size: 14)
        mailBtn.setImage(UIImage(named: "email"), for: .normal)
        mailBtn.titleEdgeInsets = UIEdgeInsets(top: 45, left: -40, bottom: 0, right: 0)
        mailBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: -20)
        mailBtn.translatesAutoresizingMaskIntoConstraints = false
        mailBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        mailBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let dateBtn = UIButton()
        moreMenu.addSubview(dateBtn)
        dateBtn.setTitle("캘린더", for: .normal)
        dateBtn.titleLabel?.font = UIFont(name: "BMHANNAAir", size: 14)
        dateBtn.setImage(UIImage(named: "date"), for: .normal)
        dateBtn.titleLabel?.textAlignment = .center
        
        dateBtn.titleEdgeInsets = UIEdgeInsets(top: 45, left: -38, bottom: 0, right: 0)
        dateBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 30, right: -35)
        dateBtn.translatesAutoresizingMaskIntoConstraints = false
        dateBtn.leftAnchor.constraint(equalTo: mailBtn.rightAnchor).isActive = true
        dateBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        dateBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        let deskBtn = UIButton()
        deskBtn.setTitle("서랍", for: .normal)
        moreMenu.addSubview(deskBtn)
        deskBtn.titleLabel?.font = UIFont(name: "BMHANNAAir", size: 14)
        deskBtn.setImage(UIImage(named: "desk"), for: .normal)
        deskBtn.titleEdgeInsets = UIEdgeInsets(top: 45, left: 0, bottom: 0, right: 37.2)
        deskBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 25, bottom: 20, right: 0)
        
        deskBtn.translatesAutoresizingMaskIntoConstraints = false
        deskBtn.leftAnchor.constraint(equalTo: dateBtn.rightAnchor).isActive = true
        deskBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        deskBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let kakaoConBtn = UIButton()
        kakaoConBtn.setTitle("카카오콘", for: .normal)
        moreMenu.addSubview(kakaoConBtn)
        
        kakaoConBtn.titleLabel?.font = UIFont(name: "BMHANNAAir", size: 14)
        kakaoConBtn.setImage(UIImage(named: "kakaoCon"), for: .normal)
        kakaoConBtn.titleEdgeInsets = UIEdgeInsets(top: 45, left: -40, bottom: 0, right: 0)
        kakaoConBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 30, bottom: 20, right: 0)
        
        
        kakaoConBtn.translatesAutoresizingMaskIntoConstraints = false
        kakaoConBtn.leftAnchor.constraint(equalTo: deskBtn.rightAnchor).isActive = true
        kakaoConBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        kakaoConBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let makersBtn = UIButton()
        makersBtn.setTitle("메이커스", for: .normal)
        moreMenu.addSubview(makersBtn)
        makersBtn.titleLabel?.font = UIFont(name: "BMHANNAAir", size: 14)
        makersBtn.setImage(UIImage(named: "makers"), for: .normal)
        makersBtn.titleEdgeInsets = UIEdgeInsets(top: 45, left: -40 , bottom: 0, right: 0)
        makersBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: -45)
        
        makersBtn.translatesAutoresizingMaskIntoConstraints = false
        makersBtn.topAnchor.constraint(equalTo: mailBtn.bottomAnchor).isActive = true
        makersBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        makersBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let giftBtn = UIButton()
        giftBtn.setTitle("선물하기", for: .normal)
        moreMenu.addSubview(giftBtn)
        giftBtn.titleLabel?.font = UIFont(name: "BMHANNAAir", size: 14)
        giftBtn.setImage(UIImage(named: "gift"), for: .normal)
        giftBtn.titleEdgeInsets = UIEdgeInsets(top: 45, left: -40, bottom: 0, right: 0)
        giftBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: -45)
        
        giftBtn.translatesAutoresizingMaskIntoConstraints = false
        giftBtn.topAnchor.constraint(equalTo: mailBtn.bottomAnchor).isActive = true
        giftBtn.leftAnchor.constraint(equalTo: makersBtn.rightAnchor).isActive = true
        giftBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        giftBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let emojiBtn = UIButton()
        emojiBtn.setTitle("이모티콘", for: .normal)
        moreMenu.addSubview(emojiBtn)
        emojiBtn.titleLabel?.font = UIFont(name: "BMHANNAAir", size: 14)
        emojiBtn.setImage(UIImage(named: "imoji"), for: .normal)
        emojiBtn.titleEdgeInsets = UIEdgeInsets(top: 45, left: -40, bottom: 0, right: 0)
        emojiBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: -45)
        
        emojiBtn.translatesAutoresizingMaskIntoConstraints = false
        emojiBtn.topAnchor.constraint(equalTo: mailBtn.bottomAnchor).isActive = true
        emojiBtn.leftAnchor.constraint(equalTo: giftBtn.rightAnchor).isActive = true
        emojiBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        emojiBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let friBtn = UIButton()
        friBtn.setTitle("프렌즈", for: .normal)
        moreMenu.addSubview(friBtn)
        friBtn.titleLabel?.font = UIFont(name: "BMHANNAAir", size: 14)
        friBtn.setImage(UIImage(named: "friendz"), for: .normal)
        friBtn.titleEdgeInsets = UIEdgeInsets(top: 45, left: -40, bottom: 0, right: 0)
        friBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: -40)
        
        friBtn.translatesAutoresizingMaskIntoConstraints = false
        friBtn.topAnchor.constraint(equalTo: mailBtn.bottomAnchor).isActive = true
        friBtn.leftAnchor.constraint(equalTo: emojiBtn.rightAnchor).isActive = true
        friBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        friBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let shopBtn = UIButton()
        shopBtn.setTitle("쇼핑하기", for: .normal)
        moreMenu.addSubview(shopBtn)
        shopBtn.titleLabel?.font = UIFont(name: "BMHANNAAir", size: 14)
        shopBtn.setImage(UIImage(named: "cart"), for: .normal)
        shopBtn.titleEdgeInsets = UIEdgeInsets(top: 45, left: -40, bottom: 0, right: 0)
        shopBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: -45)
        
        shopBtn.translatesAutoresizingMaskIntoConstraints = false
        shopBtn.topAnchor.constraint(equalTo: makersBtn.bottomAnchor).isActive = true
        shopBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        shopBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let fashionBtn = UIButton()
        fashionBtn.setTitle("패션", for: .normal)
        moreMenu.addSubview(fashionBtn)
        fashionBtn.titleLabel?.font = UIFont(name: "BMHANNAAir", size: 14)
        fashionBtn.setImage(UIImage(named: "hanger"), for: .normal)
        fashionBtn.titleEdgeInsets = UIEdgeInsets(top: 45, left: -40, bottom: 0, right: 0)
        fashionBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: -30)
        
        fashionBtn.translatesAutoresizingMaskIntoConstraints = false
        fashionBtn.topAnchor.constraint(equalTo: makersBtn.bottomAnchor).isActive = true
        fashionBtn.leftAnchor.constraint(equalTo: shopBtn.rightAnchor).isActive = true
        fashionBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        fashionBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let foodBtn = UIButton()
        foodBtn.setTitle("주문하기", for: .normal)
        moreMenu.addSubview(foodBtn)
        foodBtn.titleLabel?.font = UIFont(name: "BMHANNAAir", size: 14)
        foodBtn.setImage(UIImage(named: "food"), for: .normal)
        foodBtn.titleEdgeInsets = UIEdgeInsets(top: 45, left: -40, bottom: 0, right: 0)
        foodBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: -50)
        
        foodBtn.translatesAutoresizingMaskIntoConstraints = false
        foodBtn.topAnchor.constraint(equalTo: makersBtn.bottomAnchor).isActive = true
        foodBtn.leftAnchor.constraint(equalTo: fashionBtn.rightAnchor).isActive = true
        foodBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        foodBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let ticketBtn = UIButton()
        ticketBtn.setTitle("티켓", for: .normal)
        moreMenu.addSubview(ticketBtn)
        ticketBtn.titleLabel?.font = UIFont(name: "BMHANNAAir", size: 14)
        ticketBtn.setImage(UIImage(named: "ticket"), for: .normal)
        ticketBtn.titleEdgeInsets = UIEdgeInsets(top: 45, left: 0, bottom: 0, right: 37.2)
        ticketBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 25, bottom: 20, right: 0)
        
        ticketBtn.translatesAutoresizingMaskIntoConstraints = false
        ticketBtn.topAnchor.constraint(equalTo: makersBtn.bottomAnchor).isActive = true
        ticketBtn.leftAnchor.constraint(equalTo: foodBtn.rightAnchor).isActive = true
        ticketBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        ticketBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let gameBtn = UIButton()
        gameBtn.setTitle("게임", for: .normal)
        moreMenu.addSubview(gameBtn)
        gameBtn.titleLabel?.font = UIFont(name: "BMHANNAAir", size: 14)
        gameBtn.setImage(UIImage(named: "game"), for: .normal)
        gameBtn.titleEdgeInsets = UIEdgeInsets(top: 45, left: -40, bottom: 0, right: 0)
        gameBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: -30)
        
        gameBtn.translatesAutoresizingMaskIntoConstraints = false
        gameBtn.topAnchor.constraint(equalTo: shopBtn.bottomAnchor).isActive = true
        gameBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        gameBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let onBtn = UIButton()
        onBtn.setTitle("구독 ON", for: .normal)
        moreMenu.addSubview(onBtn)
        onBtn.titleLabel?.font = UIFont(name: "BMHANNAAir", size: 14)
        onBtn.setImage(UIImage(named: "on"), for: .normal)
        onBtn.titleEdgeInsets = UIEdgeInsets(top: 45, left: -40, bottom: 0, right: 0)
        onBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: -45)
       
        onBtn.translatesAutoresizingMaskIntoConstraints = false
        onBtn.topAnchor.constraint(equalTo: shopBtn.bottomAnchor).isActive = true
        onBtn.leftAnchor.constraint(equalTo: gameBtn.rightAnchor).isActive = true
        onBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        onBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let eungBtn = UIButton()
        eungBtn.setTitle("응", for: .normal)
        moreMenu.addSubview(eungBtn)
        eungBtn.titleLabel?.font = UIFont(name: "BMHANNAAir", size: 14)
        eungBtn.setImage(UIImage(named: "eung"), for: .normal)
        eungBtn.titleEdgeInsets = UIEdgeInsets(top: 45, left: -40, bottom: 0, right: 0)
        eungBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: -10)
        
        eungBtn.translatesAutoresizingMaskIntoConstraints = false
        eungBtn.topAnchor.constraint(equalTo: shopBtn.bottomAnchor).isActive = true
        eungBtn.leftAnchor.constraint(equalTo: onBtn.rightAnchor).isActive = true
        eungBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        eungBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let menuBtn = UIButton()
        menuBtn.setTitle("전체서비스", for: .normal)
        moreMenu.addSubview(menuBtn)
        menuBtn.titleLabel?.font = UIFont(name: "BMHANNAAir", size: 14)
        menuBtn.setImage(UIImage(named: "menu"), for: .normal)
        menuBtn.titleEdgeInsets = UIEdgeInsets(top: 45, left: -40, bottom: 0, right: 0)
        menuBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: -50)
        
        menuBtn.translatesAutoresizingMaskIntoConstraints = false
        menuBtn.topAnchor.constraint(equalTo: shopBtn.bottomAnchor).isActive = true
        menuBtn.leftAnchor.constraint(equalTo: eungBtn.rightAnchor).isActive = true
        menuBtn.widthAnchor.constraint(equalTo: moreMenu.widthAnchor, multiplier: 0.25).isActive = true
        menuBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        let ad = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        ad.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        let adView = UIView()
        ad.addSubview(adView)
        adView.topAnchor.constraint(equalTo: ad.topAnchor).isActive = true
        adView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        adView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        adView.backgroundColor = .purple
        adView.layer.cornerRadius = 20
        
        let cell = [wallet,moreMenu, ad]
        
        return cell[indexPath.row]
    }
}
