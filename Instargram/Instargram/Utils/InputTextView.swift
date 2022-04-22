import UIKit
// UploadPostController에서 사용할 textView를 커스텀
// textView를 사용할 때 플레이스홀더가 없기 때문에 직접 만들고 또 글자를 적으면 사라지는것 까지 직접 설정을 만듬


// Extensions 보면 extension으로 만들었는데 왜 얘는 하위클래스로 만들었을까?
class InputTextView: UITextView {
    // MARK: Properties

    // UploadController에서 .placeholderText 속성값으로 사용
    // didSet 값의 변경 직전 이벤트를 감지하여 해당 시점에 작업을 수행할 수 있도록 기능을 지원
    var placeholderText: String? {
        didSet { placeholderLabel.text = placeholderText }
    }
    
    // text는 UploadController에서 설정해 준다
    let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    
    var placeholderShouldCenter = true {
        didSet {
            if placeholderShouldCenter {
                placeholderLabel.anchor(left: leftAnchor, right: rightAnchor, paddingLeft: 8)
                placeholderLabel.centerY(inView: self)
            } else {
                placeholderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 6, paddingLeft: 8)
            }
        }
    }
    
    // MARK: Action
    @objc private func handleTextDidChange(){
        placeholderLabel.isHidden = !text.isEmpty   // 텍스트가 비어있지 않다면 placeholderLabel을 숨긴다
    }
    
    // MARK: LifeCycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 6, paddingLeft: 8)
        
        // 관찰자가(textDidChangeNotification) 텍스트가 있음을 알림 (handleTextDidChange)
        // ???
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
