import UIKit

private let reuseIdentifier = "UserCell"    // 식별자 문자열을 속성에 저장하는게 좋다 변경하려고 할때 여러 위치에 있을수 있기 때문에 일괄적으로 변경하기 위해서

class SearchController: UITableViewController {
    // MARK: Properties
    
    // 처음 load 할 때 users는 빈배열이다. User를 포함한 빈 배열
    private var users = [User]()        // UserService.fetchUsers에서 User값을 가져오므로 외부에 액세스할 필요가 없으므르 private사용
    private var filteredUsers = [User]()
    private let searchController = UISearchController(searchResultsController: nil) // 검색 기능 추가
    
    // 이거는 viewModel에 적어도 되지 않을까? 옮겨보기
    private var inSearchMode: Bool { return searchController.isActive && !searchController.searchBar.text!.isEmpty }
    // searchController가 내부가 활성화 되어 있으며 비어있지 않을경우 true 반환
    // 처음에는 추천친구를 다 보여주고(false) 써치바 클릭하고 글자를 작성하면(true)
    // 검색하다가 다시 검색창을 비우면 false 반환하면서 다시 추천친구목록
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        print(users)
        configureUI()
        fetchUsers()
        configureSearchController()
    }
    
    // MARK: API
    // API폴더에 UserService 파일의 UserService 구조에서 만든 fetchUsers 함수 사용
    func fetchUsers() {
        UserService.fetchUsers { users in
            self.users = users
            self.tableView.reloadData()
            print(users)
            // viewDidLoad는 한번만 호출된다. API호출에는 시간이 걸리는데 이럴경우 빈 tableView만 보여주게 될것 이 때 API가 호출되고 나서의 tableView의 데이터를 다시 불러준다
        }
    }
    
    // MARK: ConfigureUI
    private func configureUI(){
        view.backgroundColor = .white
        tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)      // 레지스터 등록
        tableView.rowHeight = 64        // 이거 중요! cell의 높이를 설정해줌 swift 내장 옵션
    }
    
    private func configureSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false   // 서치바 배경색을 흐리게하지 않기
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }
    
}

extension SearchController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inSearchMode ? filteredUsers.count : users.count
        // users.count 처음에는 빈배열 API를 받아서 reloadData하면 users가 다시 채워짐
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 재사용을 사용해야하기 때문에 사용(dequeueReusableCell)
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
        let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        // cell.user = viewModel[indexPath.row]  UserCell을 MVVM 패턴 없이 그대로 받아왔다면 이렇게 적어야 했다.
        cell.viewModel = UserCellViewModel(user: user)      // User 모델을 직접 사용하는게 아닌 viewModel 한것을 가져온다
        return cell
    }
}


// cell을 클릭했을 때의 이벤트
extension SearchController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = inSearchMode ? filteredUsers[indexPath.row] : users[indexPath.row]
        // 써치모드의 경우 filter된 user의 index가 필요하고 아닌경우 user의 index가 필요하다
        let controller = ProfileController(user: user)      // 이거 만약에 ProfileController에 init()을 만들지 않았다면 다른 방법이 있을까?
        navigationController?.pushViewController(controller, animated: true)
    }
}

// MARK: UISearchResultsUpdating
// SearchController delegate 사용
extension SearchController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercased() else { return }    // 사용자이름이 전부 소문자 이기 때문에 입력받는것 또한 소문자로만 받는다 lowercased() 사용
        filteredUsers = users.filter({ $0.username.contains(searchText) || $0.fullname.lowercased().contains(searchText) })
        self.tableView.reloadData()     // filter로 API 데이터를 다시 받아오면 tableView의 데이터 또한 업데이트 되어야 하기 때문에 사용
    }
}
