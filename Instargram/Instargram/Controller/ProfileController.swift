import UIKit

// 문자열로 사용할 경우 오타가능성이 있기 때문에 프로퍼티로 선언
// 그리고 나중에 변경할 상황이 생길때 여러곳을 바꿀 필요없이 여기서 한꺼번에 변경 가능
private let cellIdentifier = "ProfileCell"
private let headerIdentifier = "ProfileHeader"

class ProfileController: UICollectionViewController {
    
    // MARK: Properties
    // ProfileController 클래스 내부에 User에 대한 액세스 권한이 생겼음
    private var user: User          // User 모델에 값을 변경해야 하는 일이 생기는데 (self.user.isFollowed = true) 그래서 var로 선언
    // private let user: User?, var user: User 이것만 선언했는데도 Class 'ProfileController' has no initializers 에러가 나옴 init이랑 required init도 같이 적어줌
    // private var user: User? 했는데 아무에러도 안뜸
    private var posts = [Post]()
    
    
    // init을 새로 생성함으로써 위에 var user: User?의 옵셔널이 필요 없게되었다 왜?
    // ProfileController는 User가 가지고 있는 모든 정보를 사용한다 따라서 이 Controller를 User개체로 초기화하려는 것이 합리적이다
    // 따라서 이 Controller은 인스턴스화 할때마다 init의 다음 내용을 전달해야 한다
    init(user: User){
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    // 종속성 주입 사용자 지정 초기화
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        checkIfUserIsFollowed()
        fetchUserStats()
        fetchPosts()
    }
    
    // MARK: API
    
    // 현재 사용자가 해당 사용자를 팔로우 했는지 확인
    private func checkIfUserIsFollowed(){
        UserService.checkIfUserIsFollowed(uid: user.uid) { isFollowed in
            // self.user: 지금 이 컨트롤러에 선언된 user 변수 User 모델을 가르킨다
            self.user.isFollowed = isFollowed       // viewModel에 ProfileHeaderViewModel에서 followButtonText 값을 맞게 변환
            self.collectionView.reloadData()        // 다시 collectionView를 load한다 (새로고침)?
        }
    }
    
    // 선택한 사용자의 프로필의 상태(팔로우,팔로잉,포스트 수)를 보여준다.
    private func fetchUserStats() {
        UserService.fetchUserStats(uid: user.uid) { stats in
            self.user.stats = stats
            // collectionView 전체가 reload 된다
            self.collectionView.reloadData()                    // 얘도 self를 왜 꼭 써야할까?
//            self.navigationItem.title = user.username       // 왜 꼭 self를 써야될까?
        }
    }
    
    private func fetchPosts() {
        PostService.fetchPosts(forUser: user.uid) { posts in
            self.posts = posts
            self.collectionView.reloadData()
        }
    }
    
    private func configureUI(){
        navigationItem.title = user.username
        collectionView.backgroundColor = .white
        // cell 두개 등록
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    }
    
    
}


// MARK: UICollectionViewDataSource
extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ProfileCell
        cell.viewModel = PostViewModel(post: posts[indexPath.row])      // 로그인된 user의 게시글
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileHeader
        // ProfileHeader에서 만든 viewModel 프로퍼티 사용
        header.viewModel = ProfileHeaderViewModel(user: user)
        header.delegate = self
        
        return header
    }
    
}
// MARK: UICollectionViewDelegate
extension ProfileController {
    
    // collectionView의 cell을 클릭했을(선택) 때의 이벤트
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let controller = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        controller.post = posts[indexPath.row]
        navigationController?.pushViewController(controller, animated: true)
    }
}


// CollectionController여도 UICollectionViewDelegateFlowLayout 프로토콜을 준수해야 한다
// MARK: UICollectionViewDelegateFlowLayout
extension ProfileController: UICollectionViewDelegateFlowLayout {
    
    // cell과 cell 사이의 공백 길이 행과 열
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    // cell과 cell 사이의 공백 길이 행과 열
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 2) / 3      // -2는 셀이 ㅁ ㅁ ㅁ 세개가 있을때 각 사이의 여백값이기때문에 뺴줘야함
        return CGSize(width: width, height: width)  // 넓이 높이를 똑같이 주었으므로 정사각형 cell이 된다.
    }
    
    
    // collectionview 헤더부분 넓이와 높이
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 240)
    }
}

extension ProfileController: ProfileHeaderDelegate {
    func header(_ profileHeader: ProfileHeader, didTapActionButtonFor user: User) {
        if user.isCurrentUser {
            
        }else if user.isFollowed {
            UserService.unfollowUser(uid: user.uid) { error in
                self.user.isFollowed = false
                self.collectionView.reloadData()
            }
        }else {
            UserService.followUser(uid: user.uid) { error in
                self.user.isFollowed = true
                self.collectionView.reloadData()        // 새 사용자를 다시 호출한다?
            }
        }
        
    }
}
