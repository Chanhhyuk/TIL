import UIKit
import Firebase

private let identifier = "Cell"

class FeedController: UICollectionViewController {
    
    private var posts = [Post]()    
    var post: Post?
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: identifier)  // 셀 등록
        configureUI()
        fetchPosts()
    }
    
    // MARK: API
    private func fetchPosts() {
//        guard post == nil else { return }
        
        PostService.fetchPosts { posts in
            self.posts = posts
            self.collectionView.refreshControl?.endRefreshing()     // 새로고침 로딩 끝
            self.collectionView.reloadData()
        }
    }
    
    // MARK: ConfigureUI
    private func configureUI() {
        //view.backgroundColor = .systemRed  collectionView이기 때문에 이것은 작동되지 않고
        collectionView.backgroundColor = .white // 이렇게 해야 작동함
        
        // 컬렉션 뷰에 셀을 반환하도록 지시하고 있지만(아래 delegate) 컬렉션에 셀을 등록하지 않았다(register)
        // 셀을 등록해야 반환할 수 있다.
        
        // 이건 왜 post가 nil일 경우에만 로그아웃버튼이 나오게 했을까?
        if post == nil {
            navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(tapLogout))
        }
        
        title = "Feed"
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        collectionView.refreshControl = refresher
    }
    
    
    // MARK: Selector
    @objc func handleRefresh(){
        // 새로고침 하면 posts를 지웠다가 다시 reload한다(fetchPosts)
        posts.removeAll()
        fetchPosts()
    }
    
    @objc private func tapLogout(){
        do {
            try Auth.auth().signOut()       // firebase에 로그아웃을 전달?
            let controller = LoginController()
            controller.delegate = self.tabBarController as? MainTabController
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        } catch {
            print("DEBUG")
        }
    }
    
}



// 처음에 상속받을 때 UIViewController에서 collectionView를 사용했다면 extension에 UICollectionViewDataSource를 상속해야 했지만
// UICollectionViewController를 처음에 상속받았고 CollectionViewController에 UICollectionViewDataSource도 포함되어 있으므로 따로 상속하지 않아도 됨
// MARK: UICollectionViewDataSource
extension FeedController {
    // 셀의 항목 수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return post == nil ? posts.count : 1
    }
    // 각각의 셀을 정의
    // 잘보면 UICollectionViewCell을 반환하는 함수인걸 볼 수 있다.
    // 만약 1000개의 셀이 있다면 1000개를 다 사용하는게 아니라 디스플레이(화면)에 보여지는것만 메모리를 사용
    // 해당 cell이 화면에 나타나려고 할 때 메모리로 신호를 보내고 해당 셀로 이동
    // 재사용 식별자는 cuming 및 Queueing 프로세스에 도움이 된다
    // 메모리 캐시를 통해 돌아가서 재사용 식별자를 사용하여 해당 셀을 찾는다
    // 만약 생성되었던거라면 이미 셀을 사용했으니 새로 생성하는 대신 캐시에서 가져올께라고하는거
    // 위에 identifier와 동일한 식별자를 사용하고 있따?
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! FeedCell
        cell.delegate = self    // 댓글버튼 delegate 사용
        
        if let post = post {
            cell.viewModel = PostViewModel(post: post)
        } else {
            cell.viewModel = PostViewModel(post: posts[indexPath.row])
        }

        return cell
    }
}

// MARK: UICollectionVeiwFlowLayout
extension FeedController: UICollectionViewDelegateFlowLayout {
    // CGSize를 리턴
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width
        var height = width + 8 + 40 + 8 // 정사각형을 만들기위해 width값 더하기 8 위 아래 간격 40 프로필 이미지 간격
        height += 110                   // 50은 포스트 이미지 60은 댓글이랑 좋아요 버튼
        return CGSize(width: width , height: height)
    }
}

// FeedCell에서 만든 델리게이트를 위임받아서 FeedCell에서 만든 버튼을 누르면 CommentController로 push할 수 있게 한다
extension FeedController: FeedCellDelegate {
    func cell(_ cell: FeedCell, wantsToShowCommentsFor post: Post) {
        let controller = CommentController(post: post)
        navigationController?.pushViewController(controller, animated: true)
    }
    func cell(_ cell: FeedCell, didLike post: Post) {
        cell.viewModel?.post.didLike.toggle()
        // FeedController에서 cell을 delegate를 했는데 viewModel이 PostViewModel인데 FeedCell에서 선언
        
        if post.didLike {
            print("Like")
        }else{
            PostService.likePost(post: post) { error in
                cell.likeButton.setImage(UIImage(named: "like_selected") , for: .normal)
                cell.likeButton.tintColor = .red
            }
        }
    }
}
