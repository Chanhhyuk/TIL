// Controller에 cell을 정의하면 Controller가 비대해지기 때문에 따로 분류해서 작성
// 사용하고자 할때 해당 Controller에 가서 collectionView.register(FeedCell.self, forCellWithReuseIdentifier: "cell") 작성
import UIKit

// Controller에 있는게 아니라 Cell에 버튼이 있기 때문에 사용.
// 좋아요버튼은 FeedCell에 있지만 처리할 수 없고 FeedController에서 처리해야하므로 delegate로 위임함
protocol FeedCellDelegate: class {
    func cell(_ cell: FeedCell, wantsToShowCommentsFor post: Post)
    func cell(_ cell: FeedCell, didLike post: Post)
}

class FeedCell: UICollectionViewCell {
    
    var viewModel: PostViewModel? { didSet { configure() } }
    // ?옵셔널로 선언하고 사용하는곳에서 안전하게 풀어서 사용?
    
    weak var delegate: FeedCellDelegate?        // 대리자를 위임한다?
    
    // let으로 선언하면 self를 FeedCell.self 바꾸라고 나옴 lazy var로 선언하면 에러 문구가 안 뜸(업데이트 후로 바뀐거 같음)??
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.backgroundColor = .lightGray
        return imageView
    }()

    
    private let usernameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside)
        return button
    }()
    
    @objc private func didTapUsername(){
        print("test")
    }
    
    private let postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.image = #imageLiteral(resourceName: "venom-7")
        return imageView
    }()
    
    lazy var likeButton: UIButton = {        // 좋아요를 누르면 버튼의 색이 변해야 하므로 lazy var로 선언
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "like_unselected") , for: .normal)
        button.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        return button
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "comment") , for: .normal)
        button.addTarget(self, action: #selector(handleCommentButton), for: .touchUpInside)
        return button
    }()
    private let shareButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setImage(UIImage(named: "send2") , for: .normal)
        return button
    }()
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    private let postTimeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40 / 2
        addSubview(usernameButton)
        usernameButton.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
        addSubview(postImageView)
        postImageView.anchor(top: profileImageView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 8)
        postImageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1).isActive = true
        configureActionButtons()
        addSubview(likesLabel)
        likesLabel.anchor(top: likeButton.bottomAnchor, left: leftAnchor, paddingTop: -4, paddingLeft: 8)
        addSubview(captionLabel)
        captionLabel.anchor(top: likesLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
        addSubview(postTimeLabel)
        postTimeLabel.anchor(top: captionLabel.bottomAnchor, left: leftAnchor, paddingTop: 8, paddingLeft: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        guard let viewModel = viewModel else { return }
        captionLabel.text = viewModel.caption
        postImageView.sd_setImage(with: viewModel.imageUrl)     // sd_setImage 라이브러리
        profileImageView.sd_setImage(with: viewModel.userProfileImageUrl)
        usernameButton.setTitle(viewModel.username, for: .normal)
        likesLabel.text = viewModel.likesLabelText
    }
    
    // 버튼 세개를 일렬로 나열
    private func configureActionButtons() {
        let stackView = UIStackView(arrangedSubviews: [likeButton, commentButton, shareButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        addSubview(stackView)
        stackView.anchor(top: postImageView.bottomAnchor, width: 120, height: 60)
    }
    
    // MARK: Selector
    // cell이기 때문에 controller에 대한 액세스 권한이 없고 보기만 가능
    @objc private func handleCommentButton(){
        guard let viewModel = viewModel else { return }
        delegate?.cell(self, wantsToShowCommentsFor: viewModel.post)    // 이 작업을 수행하려면 작업을 위임하는곳(Feed Controller)에서 이 프로토콜을 준수해야 한다.
    }
    
    @objc private func didTapLike(){
        guard let viewModel = viewModel else { return }
        delegate?.cell(self, didLike: viewModel.post)
    }
    
}
