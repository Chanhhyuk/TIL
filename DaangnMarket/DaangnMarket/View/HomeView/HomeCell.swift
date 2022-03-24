import UIKit
import SnapKit

class HomeCell: UITableViewCell {
    
    // MARK: Properties
    private let photoView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .orange
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.text = "titleLabel"
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "timeLabel"
        label.textColor = .lightGray
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.text = "priceLabel"
        return label
    }()
    
    
    // MARK: LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: ConfigureUI
    private func configureUI(){
        addSubview(photoView)
        photoView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(15)
            make.bottom.equalTo(snp.bottom).offset(-15)
            make.left.equalTo(snp.left).offset(15)
            make.width.equalTo(130)
        }
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, timeLabel, priceLabel])
        stackView.axis = .vertical
        stackView.spacing = 5
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.top.equalTo(photoView.snp.top)
            make.left.equalTo(photoView.snp.right).offset(10)
            make.height.equalTo(50)
        }
        
        
    }
    
}
