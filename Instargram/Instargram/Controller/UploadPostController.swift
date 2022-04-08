// ImageSelector에다가 바로 적으면 될것을 왜 UploadPostController을 따로 만들었을까?
// MainController에서 만든 YPImagePickerConfiguration로 사진을 설정하고 포스트 내용을 적는 Controller
import UIKit

protocol UploadPostControllerDelegate: class {
    func controllerDidFinishUploadingPost(_ controller: UploadPostController)
}

class UploadPostController: UIViewController {
    // MARK: Properties
    weak var delegate: UploadPostControllerDelegate?
    
    var currentUser: User?
    
    var selectedImage: UIImage? {
        didSet { photoImageView.image = selectedImage }
    }
    
    private let photoImageView: UIImageView = {     // 업로드할 이미지
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // 게시글을 적을 때 여러줄을 적을것이므로 textField가 아닌 textView로 작성
    private lazy var textView: InputTextView = {
        let textView = InputTextView()
        textView.placeholderText = "Enter caption.."
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.delegate = self
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
    
    // 클릭하면 MainController로 이동해야하고, MainController에 글이 올라와야 된다
    @objc private func handleShare(){
        guard let image = selectedImage else { return }     // 사용자가 선택한 이미지
        guard let caption = textView.text else { return }   // 사용자가 작성한 textView 내용
        guard let user = currentUser else { return }
        
        showLoader(true)    // 로딩 애니메이션이 작동
        
        PostService.uploadPost(caption: caption, image: image, user: user) { error in
            self.showLoader(false)  // 업로드가 완료될때 로딩 애니메이션 해제
            if let error = error { return }
            self.delegate?.controllerDidFinishUploadingPost(self)
        }
        
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
        label.anchor(bottom: textView.bottomAnchor, right: view.rightAnchor, paddingBottom: -8 ,paddingRight: 12)
    }
}

// MARK: textViewDelegate
extension UploadPostController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        if textView.text.count > 100 { textView.deleteBackward() }   // 글자수가 100을 넘으면 작성이 안됨
        let count = textView.text.count     // 글자수 카운팅
        label.text = "\(count) / 100"
    }
}
