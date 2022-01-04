import UIKit

class TableViewCell: UITableViewCell {
    
    let cellLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 셀을 생성하고 설정한다.
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.cellSetting()
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // Cell을 설정
    func cellSetting() {
        self.labelSetting()
        self.widthAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    // Cell에 추가할 Label을 설정한다.
    func labelSetting() {
        self.addSubview(self.cellLabel)
        self.cellLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.cellLabel.text = "HELLO"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
