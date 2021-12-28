import UIKit
import Contacts

class initial: UIViewController {
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "BMHANNAPro", size: 36)
        label.text = "카카오톡 이용 안내"
        return label
    }()
    
    private let midLabel: UILabel = {
        let label = UILabel()
        label.text = "카카오톡을 이용하려면\n아래의 권한을 허용해 주세요."
        label.font = UIFont(name: "BMHANNAPro", size: 20)     // 이거 사이즈 바꿔줄때마다 name 써줘야하나?
        label.numberOfLines = 2
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    
    private let botLabel: UILabel = {
        let label = UILabel()
        label.text = "권한 허용 후 카카오톡을 시작합니다.\n아래'허용하기'를 눌러 권한을 허용해 주세요."
        label.numberOfLines = 2
        label.textColor = .gray
        return label
    }()
    
    private let callBtn: UIButton = {
        let button = UIButton()
        button.contentMode = .scaleToFill
        button.setTitle("전화", for: .normal)
        button.contentHorizontalAlignment = .left
        button.setImage(UIImage(systemName: "bubble.right"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.backgroundColor = .green
        button.addTarget(self, action: #selector(callEvent), for: .touchUpInside)
        return button
    }()
    
    private let callView: UIView = {
        let view = UIView()
        let label = UILabel()
        label.text = "내 기기에서 받은 인증 상태를 유지하고 카카오톡을\n지속적으로 이용하기 위하여 기기정보 접근 허용이 필요합니다."
        label.numberOfLines = 2
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        label.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        view.backgroundColor = .green           // 여기 앞에 있는 view는 window view 지칭하는거랑 안 겹치는걸까?
        view.isHidden = true
        return view
    }()
    
    private let addressView: UIView = {
        let view = UIView()
        let button = UIButton()
        view.addSubview(button)
        button.titleLabel?.font = UIFont(name: "BMHANNAPro", size: 26)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.setTitle("주소록", for: .normal)
        button.addTarget(self, action: #selector(addressHide), for: .touchUpInside)
        
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "내 기기에 저장된 주소록을 카카오톡을 전송하고 친구를 추가하기 위하여 주소록 권한 허용이 필요합니다."
        label.font = UIFont(name: "BMHANNAPro", size: 16)
        label.textColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 16).isActive = true
        label.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        let underLine = UIView()
        view.addSubview(underLine)
        underLine.translatesAutoresizingMaskIntoConstraints = false
        underLine.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
        underLine.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        underLine.heightAnchor.constraint(equalToConstant: 3).isActive = true
        underLine.backgroundColor = UIColor(red: 0/255, green: 0/255, blue: 0/255, alpha: 0.3)
        
        return view
    }()
    
    @objc func addressHide(){
        
        addressView.layoutIfNeeded()
    }
    
    
    @objc func callEvent(){
    }
    
    private let saveBtn: UIButton = {
        let button = UIButton()
        button.setTitle("저장", for: .normal)
        return button
    }()
    
    private let addressBtn: UIButton = {
        let button = UIButton()
        button.setTitle("주소록", for: .normal)
        return button
    }()
    
    private let arrowBtn: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 20
        button.setTitle("허용하기", for: .normal)
        button.backgroundColor = .yellow
        button.addTarget(self, action: #selector(permiss) , for: .touchUpInside)
        return button
    }()
    
    @objc func permiss() {
        let vc = login()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(topLabel)
        view.addSubview(midLabel)
        view.addSubview(callBtn)
        view.addSubview(callView)
        
        view.addSubview(addressView)
        view.addSubview(botLabel)
        view.addSubview(arrowBtn)
        
    }
    
    override func viewDidLayoutSubviews() {
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        midLabel.translatesAutoresizingMaskIntoConstraints = false
        midLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 30).isActive = true
        midLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        callBtn.translatesAutoresizingMaskIntoConstraints = false
        callBtn.topAnchor.constraint(equalTo: midLabel.bottomAnchor, constant: 50).isActive = true
        callBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        callBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        
        callView.translatesAutoresizingMaskIntoConstraints = false
        callView.topAnchor.constraint(equalTo: callBtn.bottomAnchor).isActive = true
        callView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        callView.widthAnchor.constraint(equalTo: callBtn.widthAnchor).isActive = true
        callView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        addressView.translatesAutoresizingMaskIntoConstraints = false
        
        arrowBtn.translatesAutoresizingMaskIntoConstraints = false
        arrowBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        arrowBtn.topAnchor.constraint(equalTo: callBtn.bottomAnchor, constant: 30).isActive = true
        
    }
    
}
