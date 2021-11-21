import UIKit

private var imageTimer: Timer?
private let diceImages: [UIImage] = [
    UIImage(named: "black1")!,
    UIImage(named: "black2")!,
    UIImage(named: "black3")!,
    UIImage(named: "black4")!,
    UIImage(named: "black5")!,
    UIImage(named: "black6")!
]

class ViewController: UIViewController {
    
    var lbl = UILabel()
    var btn = UIButton()
    var dice1 = UIImageView()
    var dice2 = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbl.text = "DICE GAME"
        lbl.textAlignment = .center
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        view.addSubview(lbl)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.widthAnchor.constraint(equalToConstant: 200).isActive = true
        lbl.heightAnchor.constraint(equalToConstant: 100).isActive = true
        lbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        
        dice1.image = UIImage(named: "black1.png")
        view.addSubview(dice1)
        dice1.translatesAutoresizingMaskIntoConstraints = false
        dice1.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        dice1.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        dice1.widthAnchor.constraint(equalToConstant: 150).isActive = true
        dice1.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        dice2.image = UIImage(named: "black1.png")
        view.addSubview(dice2)
        dice2.translatesAutoresizingMaskIntoConstraints = false
        dice2.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        dice2.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        dice2.widthAnchor.constraint(equalToConstant: 150).isActive = true
        dice2.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        
        btn.setTitle("Roll", for: .normal) // 버튼에 Change 텍스트를 추가
        btn.backgroundColor = .black // 버튼 배경색을 빨간색으로 설정
        btn.tintColor = .white
        view.addSubview(btn)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.widthAnchor.constraint(equalToConstant: 200).isActive = true
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        btn.addTarget(self, action: #selector(roll), for: .touchUpInside)

    }
    
    @objc func roll() {
        if btn.currentTitle! == "Roll"{
                btn.setTitle("Stop", for: .normal)
                imageTimer = Timer(fire: Date(), interval: 0.5, repeats: true) { (timer) in
                self.dice1.image = diceImages.randomElement()
                self.dice2.image = diceImages.randomElement()
            }
            RunLoop.main.add(imageTimer!, forMode: .common)
        }else {
            btn.setTitle("Roll", for: .normal)
            imageTimer!.invalidate()
        }
            
    }

}

