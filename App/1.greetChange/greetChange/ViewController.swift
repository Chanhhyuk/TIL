import UIKit

class ViewController: UIViewController {

    let btn = UIButton() // 버튼 객체 생성
    let lbl = UILabel() // label 객체 생성
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbl.textColor = .blue // 레이블 색 설정
        lbl.text = "반갑습니다" // 레이블 텍스트 설정
        lbl.textAlignment = .center // 텍스트를 가운데 정렬
        view.addSubview(lbl) // lbl을 뷰에 추가한다.
        lbl.translatesAutoresizingMaskIntoConstraints = false // 오토레이아웃을 설정하기 전에 꼭 해야 하는 과정
        lbl.widthAnchor.constraint(equalToConstant: 200).isActive = true // width값 200 설정
        lbl.heightAnchor.constraint(equalToConstant: 100).isActive = true // height 100 설정
        lbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true // x 좌표를 뷰 가운데로 설정
        lbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true // y 좌표를 루트 뷰 최상단 기준으로 100보다 떨어진 위치로 y 좌표로 설정
       
        btn.setTitle("Change", for: .normal) // 버튼에 Change 텍스트를 추가
        btn.backgroundColor = UIColor.blue // 버튼 배경색을 빨간색으로 설정
        view.addSubview(btn) // btn을 뷰에 추가한다.
        btn.translatesAutoresizingMaskIntoConstraints = false // 오토레이아웃을 설정하기 전에 꼭 해야 하는 과정
        btn.widthAnchor.constraint(equalToConstant: 200).isActive = true // width값 200설정
        btn.heightAnchor.constraint(equalToConstant: 50).isActive = true // height값 50설정
        btn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true // x좌표를 뷰 가운데로 설정
        btn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true // y좌표로 루트 뷰의 최하단 기준으로 -100보다 떨어진 위치로 y 좌표로 설정
        btn.addTarget(self, action: #selector(changeLabel), for: .touchUpInside)
        // 버튼을 클릭시(touchUpInside) changeLabel 함수 실행
    }

    @objc func changeLabel(){ // label을 바꿀 이벤트를 설정한다.
        
        if lbl.text == "반갑습니다"{ // if문을 통해서 반복 될 수 있도록 설정
            lbl.text = "안녕하세요"
            lbl.textColor = .red
            btn.backgroundColor = UIColor.red
        }else if lbl.text == "안녕하세요"{
            lbl.text = "반갑습니다"
            lbl.textColor = .blue
            btn.backgroundColor = UIColor.blue
        }
        
    }

}
