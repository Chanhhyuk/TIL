import UIKit

class InputTextView: UITextView {
    // MARK: Properties
    var placeholderText: String? {      // 텍스트 숫자를 변동될때마다 나타내기 위해 변경될때마다 실행하는 didSet 실행
        didSet { placeholderLabel.text = placeholderText }
    }
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        return label
    }()
    // MARK: Action
    @objc private func handleTextDidChange(){
        placeholderLabel.isHidden = !text.isEmpty   // 비어있지 않으면 플레이스홀더 hidden
    }
    
    // MARK: LifeCycle
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        addSubview(placeholderLabel)
        placeholderLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 6, paddingLeft: 8)
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
