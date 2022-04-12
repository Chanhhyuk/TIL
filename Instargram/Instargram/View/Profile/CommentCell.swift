import UIKit

class CommentCell: UICollectionViewCell {
    // MARK: Properties
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        let attrubutedString = NSMutableAttributedString(string: "joker ", attributes: [.font: UIFont.boldSystemFont(ofSize: 14)])
        attrubutedString.append(NSAttributedString(string: "test comment...", attributes: [.font: UIFont.systemFont(ofSize: 14)]))
        label.attributedText = attrubutedString
        return label
    }()
    
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ConfigureUI
    private func configureUI(){
        addSubview(profileImageView)
        profileImageView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 8)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40 / 2
        addSubview(commentLabel)
        commentLabel.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
    }
    
}
