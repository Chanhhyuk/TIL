import UIKit

class CommentInput: UIView {
    // MARK: Properties
    // InputTextView 만들어 논거 사용
    private let commentTextView: InputTextView = {
        let textView = InputTextView()
        textView.placeholderText = "Enter comment..."
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.isScrollEnabled = false
        textView.placeholderShouldCenter = true
        return textView
    }()
    
    private let postButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Post", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handlePostButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        autoresizingMask = .flexibleHeight      // iPhone7 같은 구형장치에서도 키보드가 알맞은 높이에 나오게끔 한다
        addSubview(postButton)
        postButton.anchor(top:topAnchor, right: rightAnchor, paddingRight: 8)
        postButton.setDimensions(height: 50, width: 50)
        addSubview(commentTextView)
        commentTextView.anchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: postButton.leftAnchor, paddingTop: 8, paddingLeft: 8, paddingBottom: 8, paddingRight: 8)
        
        let divider = UIView()
        divider.backgroundColor = .lightGray
        addSubview(divider)
        divider.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    // MARK: Selector
    @objc private func handlePostButton(){
        
    }
    
}
