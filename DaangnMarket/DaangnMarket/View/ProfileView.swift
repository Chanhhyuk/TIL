import UIKit
import SnapKit

class ProfileView: UICollectionViewCell {
    // MARK: Propertise
    private let profilePhoto: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "defaultPhoto"), for: .normal)
        return button
    }()
    
    private let sellButton: UIButton = {
        let button = UIButton()
        let imageView = UIImageView()
        imageView.image = UIImage(named: "sell")
        button.addSubview(imageView)
        button.backgroundColor = .green
        
        return button
    }()
    
    private let buyButton: UIButton = {
        let button = UIButton()
        let imageView = UIImageView()
        imageView.image = UIImage(named: "buy")
        button.addSubview(imageView)
        button.backgroundColor = .red
        return button
    }()
    
    private let heartButton: UIButton = {
        let button = UIButton()
        let imageView = UIImageView()
        imageView.image = UIImage(named: "heart")
        button.addSubview(imageView)
        button.backgroundColor = .blue
        return button
    }()
    
    
    // MARK: LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Layout
    private func layout(){
        addSubview(profilePhoto)
        addSubview(sellButton)
        addSubview(buyButton)
        addSubview(heartButton)
        
        let stackView = UIStackView(arrangedSubviews: [sellButton, buyButton, heartButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(100)
            make.top.equalTo(profilePhoto.snp.bottom).offset(50)
        }
        
        profilePhoto.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(50)
            make.left.equalTo(self.snp.left).offset(10)
        }
    }
    
    
}
