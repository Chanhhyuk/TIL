// 다른 사용자를 검색하고 사용자 이름이 실제 있는지 확인하는 뷰
import UIKit
import JGProgressHUD

class NewConversationViewController: UIViewController {
    
    private let spinner = JGProgressHUD()
    
    private let searchBar: UISearchBar = {      // 서치바 생성
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search for Users..."
        return searchBar
    }()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.isHidden = true
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell") // 셀 등록
        return table
    }()
    
    private let noResultsLabel: UILabel = {         // 검색결과가 없을때 tableView를 가리고 label을 보여준다.
        let label = UILabel()
        label.isHidden = true
        label.text = "No Results"
        label.textAlignment = .center
        label.textColor = .green
        label.font = .systemFont(ofSize: 21, weight: .medium)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        view.backgroundColor = .white
        navigationController?.navigationBar.topItem?.titleView = searchBar      // 네비게이션 타이틀 자리에 서치바
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(dismissSelf))        // 친구검색을 취소할 때
        searchBar.becomeFirstResponder()
    }
    @objc private func dismissSelf() {
        dismiss(animated: true, completion: nil)
    }
    
    
}

extension NewConversationViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}
