import UIKit

class FeedCell: UICollectionViewCell {
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.image = #imageLiteral(resourceName: "venom-7")
        return imageView
    }()
    // 정의 또는 선언에 대상을 추가하지 않는 경우 lazy 사용
    // 이 버튼은 작동하지 않지만
    // 작동하게 하려면 addTarget을 addTarget을 초기화 해줘야 한다?
    // 그 이유는 클래스가 초기화되기 전에 대상을 추가하려고 하기 때문
    // 하지만 lazy를 만들면 초기화가 발생할때까지 그런 작업을 수행하지 않는다
    // 아직 존재하지 않는 경우 대상을 아직 추가하는 것과 같이 이 버튼에 대해 아무것도 할 수 없다
    // 초기화 함수가 호출될 때까지는 존재하지 않는다.
    private lazy var usernameButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("venom", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
        button.addTarget(self, action: #selector(didTapUsername), for: .touchUpInside)
        return button
    }()
    
    @objc private func didTapUsername(){
        print("test")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(profileImageView)
        profileImageView.anchor(top: topAnchor, left: leftAnchor, paddingTop: 12, paddingLeft: 12)
        profileImageView.setDimensions(height: 40, width: 40)
        profileImageView.layer.cornerRadius = 40 / 2
        addSubview(usernameButton)
        usernameButton.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
