import UIKit
// UploadPostController에서 사용할 textView를 커스텀
// 커스텀 했기 때문에 어디서든 재사용 가능

class InputTextView: UITextView {
    // MARK: Properties
    
    // textView를 사용할 때 플레이스홀더가 없기 때문에 직접 만들고 또 글자를 적으면 사라지는것 까지 직접 설정을 만듬
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
        
        
        // 관찰자가(textDidChangeNotification) 텍스트가 있음을 알림 (handleTextDidChange)
        // name의 해당자들에게 일을 수행하라고 시킴
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
