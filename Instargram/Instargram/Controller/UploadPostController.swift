import UIKit

class UploadPostController: UIViewController {
    // MARK: Properties
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        return textView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "0/100"
        return label
    }()
    
    // MARK: Selector
    @objc private func handleCancel(){
        dismiss(animated: true, completion: nil)
    }
    @objc private func handleShare(){
        
    }
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: ConfigureUI
    private func configureUI(){
        view.backgroundColor = .white
        navigationItem.title = "Upload Post"
        // systemItem에서 cancel 기능이 있어서 사용했으나
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        // Share기능은 없으므로 커스텀해서 사용
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Share", style: .done, target: self, action: #selector(handleShare))
        view.addSubview(photoImageView)
        photoImageView.setDimensions(height: 180, width: 180)
        photoImageView.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 8)
        photoImageView.centerX(inView: view)
        photoImageView.layer.cornerRadius = 10
        
        view.addSubview(textView)
        textView.anchor(top: photoImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 12, paddingRight: 12, height: 64)
        
        view.addSubview(label)
        label.anchor(bottom: textView.bottomAnchor, right: view.rightAnchor, paddingRight: 12)
    }
}
