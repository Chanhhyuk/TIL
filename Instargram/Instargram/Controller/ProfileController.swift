import UIKit

private let cellIdentifier = "ProfileCell"
private let headerIdentifier = "ProfileHeader"

class ProfileController: UICollectionViewController {
    
    // MARK: Properties
    // Controller가 호출될때 User의 값은 nil이다 왜냐하면 API가 호출되는데는 시간이 조금 걸리기 때문
    var user: User? {
        // didSet 관찰자가 하는 일은 값이나 변수가 설정되면 이 코드가 실행
        didSet { collectionView.reloadData() }  // 사용자를 설정하고 다시 컬렉션 뷰를 로드
    }

    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        fetchUser()
    }
    
    
    private func layout(){
        collectionView.backgroundColor = .white
        // cell 두개 등록
        collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.register(ProfileHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerIdentifier)
    }
    
    // MARK: API
    // ProfileController 클래스 내부에 User데 대한 액세스 권한이 있다
    private func fetchUser() {
        UserService.fetchUser { user in
            self.user = user
            self.navigationItem.title = user.username
        }
    }
    
}


// MARK: UICollectionViewDataSource
extension ProfileController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! ProfileCell
        
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        // header cell
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as! ProfileHeader
        
        // 로그인한 username을
        if let user = user {
            header.viewModel = ProfileHeaderViewModel(user: user)
        }
        
        return header
    }
    
}
// MARK: UICollectionViewDelegate
extension ProfileController {
    
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
