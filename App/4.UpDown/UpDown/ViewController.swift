import UIKit
import SnapKit

class ViewController: UIViewController, UITextFieldDelegate {

    var randomNum = Int.random(in: 0...99)
    var life: Int = 10
    let topView = UIView()
    let lifelbl = UILabel()
    let alarmlbl = UILabel()
    let selectField = UITextField()
    
    let startBtn = UIButton()
    let selectBtn = UIButton()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
     
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
     
        return updatedText.count <= 2
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectField.delegate = self
        
        topView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        topView.backgroundColor = .blue
        view.addSubview(topView)
        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
        topView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        topView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        topView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        
        lifelbl.text = "Life: \(life)"
        lifelbl.font = UIFont.boldSystemFont(ofSize: 20)
        lifelbl.textAlignment = .center
        view.addSubview(lifelbl)
        lifelbl.translatesAutoresizingMaskIntoConstraints = false
        lifelbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 90).isActive = true
        lifelbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lifelbl.widthAnchor.constraint(equalToConstant: 150).isActive = true
        lifelbl.heightAnchor.constraint(equalToConstant: 20).isActive = true

        alarmlbl.text = "선택하세요"
        alarmlbl.textAlignment = .center
        alarmlbl.backgroundColor = .white
        view.addSubview(alarmlbl)
        alarmlbl.translatesAutoresizingMaskIntoConstraints = false
        alarmlbl.topAnchor.constraint(equalTo: topView.topAnchor, constant: 10).isActive = true
        alarmlbl.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 10).isActive = true
        alarmlbl.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -10).isActive = true
        alarmlbl.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        selectField.text = ""
        selectField.keyboardType = .numberPad
        selectField.placeholder = "1 ~ 99 까지의 숫자를 입력해주세요"
        selectField.textAlignment = .center
        selectField.backgroundColor = .white
        view.addSubview(selectField)
        selectField.translatesAutoresizingMaskIntoConstraints = false
        selectField.topAnchor.constraint(equalTo: alarmlbl.bottomAnchor, constant: 10).isActive = true
        selectField.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 10).isActive = true
        selectField.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -10).isActive = true
        selectField.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -10).isActive = true
        
        startBtn.setTitle("START", for: .normal)
        startBtn.backgroundColor = .red
        view.addSubview(startBtn)
        startBtn.translatesAutoresizingMaskIntoConstraints = false
        startBtn.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10).isActive = true
        startBtn.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 0).isActive = true
        startBtn.widthAnchor.constraint(equalToConstant: 150).isActive = true
        startBtn.heightAnchor.constraint(equalToConstant: 90).isActive = true
        startBtn.addTarget(self, action: #selector(startGame), for: .touchUpInside)
        
        selectBtn.setTitle("SELECT", for: .normal)
        selectBtn.backgroundColor = .blue
        selectBtn.isEnabled = false
        selectBtn.setTitleColor(.gray, for: .normal)
        view.addSubview(selectBtn)
        selectBtn.translatesAutoresizingMaskIntoConstraints = false
        selectBtn.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 10).isActive = true
        selectBtn.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: 0).isActive = true
        selectBtn.widthAnchor.constraint(equalToConstant: 150).isActive = true
        selectBtn.heightAnchor.constraint(equalToConstant: 90).isActive = true
        selectBtn.addTarget(self, action: #selector(numChoice(_:)), for: .touchUpInside)
        
    }
    
    @objc func startGame() {
        if startBtn.currentTitle == "START" {
            selectBtn.isEnabled = true
            selectBtn.setTitleColor(.white, for: .normal)
            startBtn.setTitle("RESET", for: .normal)
        }else {
            life = 10
            lifelbl.text = "Life: \(life)"
            alarmlbl.text = "선택하세요"
            randomNum = Int.random(in: 0...99)
            selectBtn.isEnabled = false
            selectBtn.setTitleColor(.gray, for: .normal)
            startBtn.setTitle("START", for: .normal)
            lifelbl.textColor = .black
            selectField.text = ""
        }
        
    }
    
    @objc func numChoice(_ sender: UIButton) {
        if selectField.text == "" {
            return
        }else if Int(selectField.text!)! < randomNum {
            alarmlbl.text = "Up!"
            selectField.text = ""
            life -= 1
            lifelbl.text = "Life: \(life)"
        }else if Int(selectField.text!)! > randomNum {
            alarmlbl.text = "Down!"
            selectField.text = ""
            life -= 1
            lifelbl.text = "Life: \(life)"
        }else {
            alarmlbl.text = "Bingo"
            selectBtn.isEnabled = false
            selectBtn.setTitleColor(.gray, for: .normal)
        }
        
        
        if life == 0 {
            alarmlbl.text = "Game Over!"
            selectBtn.isEnabled = false
            selectBtn.setTitleColor(.gray, for: .normal)
        }else if life < 4 {
            lifelbl.textColor = .red
        }
        

    }

    
}
