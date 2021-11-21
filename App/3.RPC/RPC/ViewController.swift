import UIKit

private var imageTimer: Timer?
private let Images: [UIImage] = [
    UIImage(named: "rock")!,
    UIImage(named: "paper")!,
    UIImage(named: "scissors")!,
]

let win = UIAlertController(title: "이겼습니다😄", message: "", preferredStyle: UIAlertController.Style.alert)
let draw = UIAlertController(title: "비겼습니다😐", message: "", preferredStyle: UIAlertController.Style.alert)
let lose = UIAlertController(title: "졌습니다😣", message: "", preferredStyle: UIAlertController.Style.alert)
let okAction = UIAlertAction(title: "OK", style: .default) { (action) in }

class ViewController: UIViewController {

    var topLabel = UILabel()

    var comSelect = UILabel()
    var userSelect = UILabel()
    
    var userImage = UIImageView()
    var comImage = UIImageView()
    
    var comRPC = UILabel()
    var userRPC = UILabel()
    
    var rBtn = UIButton()
    var pBtn = UIButton()
    var sBtn = UIButton()
    
    var startBtn = UIButton()
    var selectBtn = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        topLabel.text = "선택하세요"
        topLabel.textAlignment = .center
        view.addSubview(topLabel)
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.topAnchor.constraint(equalTo: view.topAnchor , constant: 100).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        comImage.image = UIImage(named: "ready")
        view.addSubview(comImage)
        comImage.translatesAutoresizingMaskIntoConstraints = false
        comImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        comImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        comImage.widthAnchor.constraint(equalToConstant: 170).isActive = true
        comImage.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        userImage.image = UIImage(named: "ready")
        view.addSubview(userImage)
        userImage.translatesAutoresizingMaskIntoConstraints = false
        userImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        userImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 170).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 170).isActive = true
        
        comSelect.text = "컴퓨터의 선택"
        comSelect.textAlignment = .center
        view.addSubview(comSelect)
        comSelect.translatesAutoresizingMaskIntoConstraints = false
        comSelect.bottomAnchor.constraint(equalTo: comImage.topAnchor, constant: -20).isActive = true
        comSelect.leftAnchor.constraint(equalTo: comImage.leftAnchor, constant: 0).isActive = true
        comSelect.widthAnchor.constraint(equalToConstant: 170).isActive = true
        comSelect.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        comRPC.text = "준비"
        comRPC.textAlignment = .center
        view.addSubview(comRPC)
        comRPC.translatesAutoresizingMaskIntoConstraints = false
        comRPC.topAnchor.constraint(equalTo: comImage.bottomAnchor, constant: 20).isActive = true
        comRPC.leftAnchor.constraint(equalTo: comImage.leftAnchor, constant: 0).isActive = true
        comRPC.widthAnchor.constraint(equalToConstant: 170).isActive = true
        comRPC.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        userSelect.text = "나의 선택"
        userSelect.textAlignment = .center
        view.addSubview(userSelect)
        userSelect.translatesAutoresizingMaskIntoConstraints = false
        userSelect.bottomAnchor.constraint(equalTo: userImage.topAnchor, constant: -20).isActive = true
        userSelect.leftAnchor.constraint(equalTo: userImage.leftAnchor, constant: 0).isActive = true
        userSelect.widthAnchor.constraint(equalToConstant: 170).isActive = true
        userSelect.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        userRPC.text = "준비"
        userRPC.textAlignment = .center
        view.addSubview(userRPC)
        userRPC.translatesAutoresizingMaskIntoConstraints = false
        userRPC.topAnchor.constraint(equalTo: userImage.bottomAnchor, constant: 20).isActive = true
        userRPC.leftAnchor.constraint(equalTo: userImage.leftAnchor, constant: 0).isActive = true
        userRPC.widthAnchor.constraint(equalToConstant: 170).isActive = true
        userRPC.heightAnchor.constraint(equalToConstant: 20).isActive = true
     
        startBtn.setTitle("START", for: .normal)
        startBtn.tintColor = .white
        startBtn.backgroundColor = .red
        view.addSubview(startBtn)
        startBtn.translatesAutoresizingMaskIntoConstraints = false
        startBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        startBtn.leftAnchor.constraint(equalTo: comImage.leftAnchor, constant: 0).isActive = true
        startBtn.widthAnchor.constraint(equalToConstant: 170).isActive = true
        startBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        startBtn.addTarget(self, action: #selector(start), for: .touchUpInside)
        
        selectBtn.setTitle("SELECT", for: .normal)
        selectBtn.tintColor = .white
        selectBtn.backgroundColor = .blue
        view.addSubview(selectBtn)
        selectBtn.translatesAutoresizingMaskIntoConstraints = false
        selectBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        selectBtn.rightAnchor.constraint(equalTo: userImage.rightAnchor, constant: 0).isActive = true
        selectBtn.widthAnchor.constraint(equalToConstant: 170).isActive = true
        selectBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        selectBtn.addTarget(self, action: #selector(selec), for: .touchUpInside)
        
        sBtn.setTitle("가위", for: .normal)
        sBtn.tintColor = .white
        sBtn.backgroundColor = .green
        view.addSubview(sBtn)
        sBtn.translatesAutoresizingMaskIntoConstraints = false
        sBtn.bottomAnchor.constraint(equalTo: startBtn.topAnchor, constant: -50).isActive = true
        sBtn.leftAnchor.constraint(equalTo: comImage.leftAnchor, constant: 0).isActive = true
        sBtn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        sBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        sBtn.addTarget(self, action: #selector(sEvent), for: .touchUpInside)
        
        rBtn.setTitle("바위", for: .normal)
        rBtn.tintColor = .white
        rBtn.backgroundColor = .green
        view.addSubview(rBtn)
        rBtn.translatesAutoresizingMaskIntoConstraints = false
        rBtn.bottomAnchor.constraint(equalTo: startBtn.topAnchor, constant: -50).isActive = true
        rBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        rBtn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        rBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        rBtn.addTarget(self, action: #selector(rEvent), for: .touchUpInside)
        
        pBtn.setTitle("보", for: .normal)
        pBtn.tintColor = .white
        pBtn.backgroundColor = .green
        view.addSubview(pBtn)
        pBtn.translatesAutoresizingMaskIntoConstraints = false
        pBtn.bottomAnchor.constraint(equalTo: startBtn.topAnchor, constant: -50).isActive = true
        pBtn.rightAnchor.constraint(equalTo: userImage.rightAnchor, constant: 0).isActive = true
        pBtn.widthAnchor.constraint(equalToConstant: 100).isActive = true
        pBtn.heightAnchor.constraint(equalToConstant: 100).isActive = true
        pBtn.addTarget(self, action: #selector(pEvent), for: .touchUpInside)
    }
    
    @objc func sEvent(){
        userImage.image = UIImage(named: "scissors")
        userRPC.text = "가위"
    }
    
    @objc func rEvent(){
        userImage.image = UIImage(named: "rock")
        userRPC.text = "바위"
    }
    
    @objc func pEvent(){
        userImage.image = UIImage(named: "paper")
        userRPC.text = "보"
    }
    
    @objc func start() {
        if startBtn.currentTitle! == "START"{
            startBtn.setTitle("RESET", for: .normal)
            startBtn.backgroundColor = .purple
            imageTimer = Timer(fire: Date(), interval: 0.1, repeats: true) { (timer) in
                self.comImage.image = Images.randomElement()
                
                if self.comImage.image == Images[0]{
                    self.comRPC.text = "바위"
                }else if self.comImage.image == Images[1] {
                    self.comRPC.text = "보"
                }else {
                    self.comRPC.text = "가위"
                }
                
        }
            RunLoop.main.add(imageTimer!, forMode: .common)
            
        }else{
            imageTimer!.invalidate()
            startBtn.setTitle("START", for: .normal)
            startBtn.backgroundColor = .red
            comImage.image = UIImage(named: "ready")
            userImage.image = UIImage(named: "ready")
        }
    }
    
    @objc func selec() {
        imageTimer!.invalidate()
        
        if comImage.image == userImage.image {
            topLabel.text = "비겼습니다!"
            draw.addAction(okAction)
            present(draw, animated: false, completion: nil)
        } else if comRPC.text == "가위" && userRPC.text == "바위" || comRPC.text == "바위" && userRPC.text == "보"  || comRPC.text == "보" && userRPC.text == "가위"{
            topLabel.text = "이겼습니다!"
            win.addAction(okAction)
            present(win, animated: false, completion: nil)
        } else{
            topLabel.text = "졌습니다!"
            lose.addAction(okAction)
            present(lose, animated: false, completion: nil)
        }
        
    }


}

