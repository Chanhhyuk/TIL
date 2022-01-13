// 메인 화면, 로그인 했다면 여기가 main 로그인 하지 않았다면 로그인 창으로 바로 넘어간다.
import UIKit
import FirebaseAuth
import JGProgressHUD

class ConversationsViewController: UIViewController { // conversations: 대화

    private let spinner = JGProgressHUD(style: .dark)
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = true       // 대화가 없는 경우 빈 테이블뷰를 보여주고 싶지 않으므로
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell") // 셀 등록
        return tableView
    }()
    
    private let noConversationsLabel: UILabel = {   // 대화가 없는 경우 레이블 출력
        let label = UILabel()
        label.text = "No Conversations!"
        label.textAlignment = .center
        label.textColor = .gray
        label.font = .systemFont(ofSize: 21, weight: .medium)
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(didTapComposeButton))    // 네비게이션 오른쪽에 친구추가 버튼
        view.addSubview(tableView)
        view.addSubview(noConversationsLabel)
        setupTableView()
        fetchConversation()
    }
    
    @objc private func didTapComposeButton() {      // 친구 추가 탭으로 이동
        let vc = NewConversationViewController()
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 사용자가 로그인 했는지 확인 로그인했으면 화면을 유지하고 하지 않았으면 로그인 화면을 표시
        validateAuth()
    }
    
    private func validateAuth() {
        if FirebaseAuth.Auth.auth().currentUser == nil {        // 사용자값이 nil이라면 로그인페이지로 ㄱㄱ
            let vc = LoginViewController()
            let nav = UINavigationController(rootViewController: vc)    //⭐️
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: false)           // animated true로 줄시 메인화면 살짝 보이면서 로그인창으로 가짐
        }
    }
    private func setupTableView(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    private func fetchConversation(){
        tableView.isHidden = false
    }

}

// 테이블 뷰 델리게이트
extension ConversationsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {   // 행의 개수를 return
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)    // 셀 하나를 재사용?
        cell.textLabel?.text = "Hello World"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { // 지정된 행이 선택되었을 때
        let vc = ChatViewController()
        vc.title = "Jenny Smith"
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
