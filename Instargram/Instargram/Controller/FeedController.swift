import UIKit


class FeedController: UICollectionViewController {
    
    private let identifier = "Cell"
    
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // viewDidLayoutSubviews에 적었을때 크러쉬가 났음 순서 문제인듯 함
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: identifier)
    }
    
    // layout과 관련된 메서드
    
    override func viewDidLayoutSubviews() {
        //view.backgroundColor = .systemRed  collectionView이기 때문에 이것은 작동되지 않고
        collectionView.backgroundColor = .white // 이렇게 해야 작동함
        
        // 컬렉션 뷰에 셀을 반환하도록 지시하고 있지만 컬렉션에 셀을 등록하지 않았다
        // 셀을 등록해야 반환할 수 있다.
    }
    
    
    
}

// 처음에 상속받을 때 UIViewController에서 collectionView를 사용했다면 extension에 UICollectionViewDataSource를 상속해야 했지만
// UICollectionViewController를 처음에 상속받았고 CollectionViewController에 UICollectionViewDataSource도 포함되어 있으므로 따로 상속하지 않아도 됨
// MARK: UICollectionViewDataSource
extension FeedController {
    // 셀의 항목 수
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
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
