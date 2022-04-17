import UIKit

struct CommentViewModel {
    private let comment: Comment
    
    var profileImageUrl: URL? {     // 위에 Comment는 ?를 안 붙였는데 여기 URL은 왜 ?를 붙였을까?
        return URL(string: comment.profileImageUrl)
    }

    init(comment: Comment) {
        self.comment = comment
    }
    
    func commentLabelText() -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: "\(comment.username) ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedString.append(NSAttributedString(string: comment.commentText, attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        return attributedString
    }
    
    // cell 크기가 유동적으로 변해야 text가 길어져도 cell 높이를 늘릴 수 있다.
    // viewModel 내부에서 view의 너비에 접근할 수 없기 때문에 이것을 in으로 전달
    func size(forWidth width: CGFloat) -> CGSize {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = comment.commentText
        label.lineBreakMode = .byWordWrapping
        label.setWidth(width)
        return label.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
    
}
