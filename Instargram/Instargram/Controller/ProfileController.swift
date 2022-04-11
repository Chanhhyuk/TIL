import UIKit

// 문자열로 사용할 경우 오타가능성이 있기 때문에 프로퍼티로 선언
private let cellIdentifier = "ProfileCell"
private let headerIdentifier = "ProfileHeader"

class ProfileController: UICollectionViewController {
    
    // MARK: Properties
    private var user: User          // User 모델에 값을 변경해야 하는 일이 생기는데 (self.user.isFollowed = true) 그래서 var로 선언
    private var posts = [Post]()
    
    // 의존성 주입?
    init(user: User){
        self.user = user
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
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
            self.collectionView.reloadData()
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
        
        // user가 안전하게 포장을 풀면 사용
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileHeader
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
