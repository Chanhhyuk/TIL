import UIKit

class StartController: UIViewController {
    
    // MARK: Properties
    private let mainImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "logo")
        return imageView
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        label.text = "당신 근처의 당근마켓"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textAlignment = .center
        return label
    }()
    
    private let bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "내 동네를 설정하고 \n 당근마켓을 시작해보세요."
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private let startButton: UIButton = {
        let button = UIButton()
        button.setTitle("시작하기", for: .normal)
        button.backgroundColor = .orange
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(handleStartButton), for: .touchUpInside)
        return button
    }()
    
    private let signLabel: UILabel = {
        let label = UILabel()
        label.text = "이미 계정이 있나요?"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(.orange, for: .normal)
        button.addTarget(self, action: #selector(handleSignInButton), for: .touchUpInside)
        return button
    }()
       
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        view.backgroundColor = .systemBackground
    }
    
    // MARK: ConfigureUI
    private func configureUI(){
        let topStackView = UIStackView(arrangedSubviews: [mainImage,topLabel,bottomLabel])
        topStackView.axis = .vertical
        topStackView.spacing = 10
        view.addSubview(topStackView)
        topStackView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY).multipliedBy(0.7)
            make.width.equalTo(200)
            make.height.equalTo(300)
        }
        
        let signInStackView = UIStackView(arrangedSubviews: [signLabel,signInButton])
        signInStackView.axis = .horizontal
        
        view.addSubview(signInStackView)
        signInStackView.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.bottom).offset(-50)
            make.width.equalTo(160)
        }
        
        view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(signInStackView.snp.top).offset(-20)
            make.width.equalTo(view.snp.width).multipliedBy(0.8)
            make.height.equalTo(50)
        }
    
    }
    // MARK: Selector
    @objc private func handleStartButton(){
        let vc = SignUpController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func handleSignInButton(){
        let vc = SignInController()
        navigationController?.pushViewController(vc, animated: true)
    }

}
