import UIKit

class begin: UIViewController {
    
    let beginLabel = UILabel()
    let joinBtn = UIButton()
    let facebookBtn = UIButton()
    let googleBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beginLabel.text = "내 마음에 꼭 드는 또 다른 플레이리스트를 발견해보세요."
        view.addSubview(beginLabel)
        beginLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            beginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            beginLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        
        joinBtn.backgroundColor = .green
        joinBtn.setTitle("가입하기", for: .normal)
        view.addSubview(joinBtn)
        joinBtn.translatesAutoresizingMaskIntoConstraints = false
        
    }
}
