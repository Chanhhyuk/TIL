import UIKit

class PokemonCell: UICollectionViewCell {
    
    var pokemon: Pokemon? {
        didSet{
            textLabel.text = pokemon?.name
            imageView.image = pokemon?.image
        }
    }
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var textView: UIView = {
        let textView = UIView()
        textView.backgroundColor = .red
        return textView
    }()
    
    private lazy var textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        viewComponents()
        addView()
        layoutSubviews()
    }
    
    private func addView(){
        self.addSubview(imageView)
        self.addSubview(textView)
        self.addSubview(textLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(self.snp.height).multipliedBy(0.7)
            make.width.equalTo(self.snp.width)
        }
        textView.snp.makeConstraints { make in
            make.height.equalTo(self.snp.height).multipliedBy(0.3)
            make.width.equalTo(self.snp.width)
            make.top.equalTo(imageView.snp.bottom)
        }
        textLabel.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.centerY.equalTo(textView.snp.centerY)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func viewComponents(){
        self.backgroundColor = .tertiarySystemGroupedBackground
    }
    
}
