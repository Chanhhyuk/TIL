import UIKit
// init(placeholder)처럼 파라미터값을 주는건 필수가 아니다. 사용하지 않는다면 customTextField는 채용하면서도 placeholder는 따로 설정해주어도 됨
// 하지만 지금같은경우 저걸 사용해주지 않는다면 placeholder와 더해서 attributedPlaceholder을 따로 설정해줘야 한다

class CustomTextField: UITextField{     // 상속하는 상위클래스는 UITextField
    init(placeholder: String) {      // 커스텀 하기 위해 override 삭제
        super.init(frame: .zero)        // 이걸 왜 사용하는지 이해하기 위해선 객체지향프로그래밍 공부 필요
        
        let spacer = UIView()
        spacer.setDimensions(height: 50, width: 12)
        leftView = spacer
        leftViewMode = .always
        borderStyle = .none             // textField를 상속받기 때문에 앞에 textField가 있는것과 같다
        textColor = .white
        keyboardAppearance = .dark
        keyboardType = .emailAddress
        backgroundColor = UIColor(white: 1, alpha: 0.1)
        setHeight(50)
        attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: UIColor(white: 1, alpha: 0.7)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
