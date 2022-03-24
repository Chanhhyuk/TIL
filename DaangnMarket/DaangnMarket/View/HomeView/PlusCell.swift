import UIKit

class PlusCell: UITableViewCell {
    // MARK: Properties
    private let jobButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "알바"
        return button
    }()
    
    private let classButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.text = "과외/클래스"
        return button
    }()
    
    
    // MARK: LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    // MARK: ConfigureUI
    private func configureUI(){
        let stackView = UIStackView(arrangedSubviews: [jobButton,classButton])
        backgroundColor = .black
        stackView.axis = .vertical
        addSubview(stackView)
        stackView.frame = CGRect(x: 0, y: 0, width: 100, height: 500)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
