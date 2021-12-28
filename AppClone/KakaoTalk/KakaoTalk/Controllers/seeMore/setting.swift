import UIKit

class setting : UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    func tableView() {
        let tableView: UITableView = {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(tableView)
            return tableView
        }()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    private let setLabel = ["공지사항","실험실","버전정보","개인/보안","알림","친구","채팅","멀티프로필","문자 모아보기","화면","테마","통화","기타","고객센터/도움말"]
    private let setImage = ["notice","exper","info","secu","bell","friendOff","chatOff","friendAdd","paper","bright","theme","call","otherOff","question"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setLabel.count       // 배열의 크기만큼 return
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = setLabel[indexPath.row] // 왼쪽 레이블부분은 0번째 데이터 오른쪽은 textLabel부분에 detailTextLabel
        cell.imageView?.image = UIImage(named: "\(setImage[indexPath.row])" )
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0: self.performSegue(withIdentifier: "photoObjectDetection", sender: nil)
        case 1: self.performSegue(withIdentifier: "realTimeObjectDetection", sender: nil)
        case 2: self.performSegue(withIdentifier: "facialAnalysis", sender: nil)
        default:
            return
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
             // 네비게이션 기본설정인 Back에서 바꿔줌
        tableView()
        navigationItem.backButtonTitle = ""
    }
    
}
