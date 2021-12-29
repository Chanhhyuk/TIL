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
    private let callView: UIView = {
        let view = UIView()
        let button = UIButton()
        view.addSubview(button)
        button.titleLabel?.font = UIFont(name: "BMHANNAPro", size: 26)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.setTitle("전화", for: .normal)
        
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "내 기기에서 받은 인증 상태를 유지하고 카카오톡을 지속적으로 이용하기 위하여 기기정보 접그 허용이 필요합니다."
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
    
    private let storgeView: UIView = {
        let view = UIView()
        let button = UIButton()
        view.addSubview(button)
        button.titleLabel?.font = UIFont(name: "BMHANNAPro", size: 26)
        button.contentHorizontalAlignment = .left
        button.translatesAutoresizingMaskIntoConstraints = false
        button.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.setTitle("저장", for: .normal)
        
        let label = UILabel()
        label.numberOfLines = 2
        label.text = "내 기기에서 사진, 동영상 및 파일을 저장하고 카카오톡으로 전송하기 위하여 저장 접근 허용이 필요합니다."
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
        
        view.addSubview(callView)
        view.addSubview(storgeView)
        view.addSubview(addressView)
        
        view.addSubview(arrowBtn)
        
    }
    
    override func viewDidLayoutSubviews() {
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        midLabel.translatesAutoresizingMaskIntoConstraints = false
        midLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 30).isActive = true
        midLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        callView.translatesAutoresizingMaskIntoConstraints = false
        callView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        callView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        callView.topAnchor.constraint(equalTo: midLabel.bottomAnchor, constant: 50).isActive = true
        
        storgeView.translatesAutoresizingMaskIntoConstraints = false
        storgeView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        storgeView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        storgeView.topAnchor.constraint(equalTo: callView.bottomAnchor, constant: 150).isActive = true
        
        addressView.translatesAutoresizingMaskIntoConstraints = false
        addressView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addressView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        addressView.topAnchor.constraint(equalTo: storgeView.bottomAnchor, constant: 150).isActive = true
        
        arrowBtn.translatesAutoresizingMaskIntoConstraints = false
        arrowBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        arrowBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9).isActive = true
        arrowBtn.topAnchor.constraint(equalTo: addressView.bottomAnchor, constant: 150).isActive = true
        
    }
    
}
