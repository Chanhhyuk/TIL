import UIKit

// 이 파일에 프로토콜을 생성한 다음 대리자를 사용해서 commentController로 대신 처리하라고 대리자로 위임한다 (일을 넘겨준다)

protocol CommentInputDelegate: class {
    func inputView(_ inputView: CommentInput, wantsToUploadComment comment: String)
}

class CommentInput: UIView {
    // MARK: Properties
    
    // inputView를 호출하는데 사용할 실제 대리자
    weak var delegate: CommentInputDelegate?
    
    
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
        backgroundColor = .white        // 기본 색상은 claer인데 그럴 경우 댓글이 완전이 가려지지 않음
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
        delegate?.inputView(self, wantsToUploadComment: commentTextView.text)
    }
    
    // 댓글을 작성하면
    func clearCommentTextView() {
        commentTextView.text = nil      // 글이 지워지고
        commentTextView.placeholderLabel.isHidden = false   // 숨겨져 있던 플레이스홀더가 생긴다.
    }
    
}
