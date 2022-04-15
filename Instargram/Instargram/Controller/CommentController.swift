import UIKit
// 댓글창

private let reuseIdentifier = "CommentCell"

class CommentController: UICollectionViewController{
    // MARK: Properties
    private let post: Post
    private var comments = [Comment]()
    
    private lazy var commentInputView: CommentInput = {
        let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
        let cv = CommentInput(frame: frame)
        cv.delegate = self      // CommentInput에서 만든 delegate를 사용하기 위해
        return cv
    }()
    
    // 사용자 초기화?
    init(post: Post) {
        self.post = post
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchComments()
    }
    
    // textfield, textView안에 내장된 inputAccessoryView 프로퍼티를 UIView에 대입
    // 빈화면 터치시 키보드가 내려감
    override var inputAccessoryView: UIView? {
        get { return commentInputView }
    }
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    // tabbar를 숨김
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: API
    private func fetchComments() {
        CommentService.fetchComments(forPost: post.postId) { comments in
            self.comments = comments
            self.collectionView.reloadData()
        }
    }
    
    
    // MARK: configureUI
    private func configureUI(){
        navigationItem.title = "Comments"
        collectionView.backgroundColor = .white
        collectionView.register(CommentCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.alwaysBounceVertical = true          // collectionView 스크롤이 콘텐츠뷰의 끝에 도달할 때 튀어 오르기가 항상 발생하는지를 결정하는 부울 값
        collectionView.keyboardDismissMode = .interactive   // 스크롤을 내릴 때 키보드도 함께 내린다.       .ondrug가 더 확실한거 같음
    }
    
}

// cell의 갯수와 어떤 cell을 사용할 것인지
extension CommentController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comments.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        return cell
    }
}

// cell의 크기
extension CommentController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }
}

extension CommentController: CommentInputDelegate {             // CommentInput에서 위임한일을 여기 컨트롤러에서 처리한다.
    func inputView(_ inputView: CommentInput, wantsToUploadComment comment: String) {
        
        guard let tab = tabBarController as? MainTabController else { return }
        guard let user = tab.user else { return }
        
        showLoader(true)
        
        CommentService.uploadComment(comment: comment, postID: post.postId, user: user) { error in
            self.showLoader(false)
            inputView.clearCommentTextView()
        }
    }
}
