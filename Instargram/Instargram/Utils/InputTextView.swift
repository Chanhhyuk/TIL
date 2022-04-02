import UIKit
// UploadPostController에서 사용할 textView를 커스텀
// 커스텀 했기 때문에 어디서든 재사용 가능

class InputTextView: UITextView {
    // MARK: Properties
    
    var placeholderText: String? {
        //
        didSet { placeholderLabel.text = placeholderText }
    }
    
    private let placeholderLabel: UILabel = {   // textField와 다르게 textView에는 placeholder가 없음. 그래서 직접 만듬
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
    // MARK: Action
    @objc private func handleTextDidChange(){
        placeholderLabel.isHidden = !text.isEmpty   // !(텍스트가 비어있다면) !(true) = false, 텍스트가 비어있지 않다면 플레이스홀더를 숨긴다.
    }
    
    // MARK: LifeCycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 6, paddingLeft: 8)
        
        // button은 addTarget을 할 수 있는데 label은 못 함 그래서 이렇게 따로 만듬
        // UITextField delegate와 동일하다
        // 텍스트가 변경되면 관찰자에게 텍스트가 변경되었음을 알리고 알림을 받으면 handleTextDidChange 함수 호출
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
