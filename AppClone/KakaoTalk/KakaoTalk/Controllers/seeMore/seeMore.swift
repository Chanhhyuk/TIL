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
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let wallet = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        wallet.backgroundColor = UIColor(red: 249, green: 224, blue: 0, alpha: 1)
        wallet.heightAnchor.constraint(equalToConstant: 150).isActive = true
        wallet.selectionStyle = .none
        
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
        remiBtn.widthAnchor.constraint(equalToConstant: 50).isActive = trueg
        
        return wallet
    }
}
