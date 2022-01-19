# PokemonCollection
- extension과 static을 이용해서 전역적으로 사용할 color 생성
- 네비게이션에 버튼을 생성했는데 얘가 기본색이 link색이였다 그래서 씬 델리게이트에서 UIButton.appearance().tintColor = .systemBackground 값을줌
- class에 UICollectionView로 상속받으면 viewdidLoad가 override가 되지 않았고 UICollectionViewController 컨트롤러를 상속받아야 overrider가 되었다
- collectionView에 cell을 넣는것은 몇개 더 해야하는게 있었지만 대부분 tableView생성과 비슷했음
- 포켓몬 API 방법 3시간째 찾고 있음 혼자 공부하는거 서럽다 ㅠ

1. iOS15 업데이트가 된 이후부터 네비게이션 바가 확장이 되면서 scrollEdgeAppearance는 기본적으로 투명한 배경으로 생성이 되면서 뒤에 컨텐츠가 없는 경우 기본적으로 투명한 배경색으로 보이게 변하였다
- navigationController?.navigationBar.tintColor이 먹히지 않음 (😡바뀐방식 구현해보려고 반나절 날림 ㅅㅂ...)
- 씬 델리게이트에는 안되고 앱 델리게이트에다가 하닌깐 되긴함
- tintColor 평범하게 사용하는 방법을 좀 알고 싶다 😭

2. 네비게이션에 barTintColor로 색상을 주면 원래 색상보다 조금더 연하게 구현되는데 원래 색상으로 구현하고 싶으면
- navigationController?.navigationBar.isTranslucent = false

3. color를 사용할 때 system.color를 사용하는게 좋다
- ex)collectionView.backgroundColor = .systemBackground
- 다크모드를 할 때 따로 설정하지 않아도 자동으로 변경된다.
- 앱스토어에 올려진 다른 앱들도 많이 사용하기 때문에 다른 앱들과 위화감이 적다.

4. 콜렉션뷰를 사용하려니 UICollectionView must be initialized with a non-nil layout parameter 에러
- UICollectionView는 초기화할때 CollectionViewLayout을 포함해서 초기화 해줘야 한다 컴파일 오류는 나지 않지만 런타임에러가 발생한다
- let layout = UICollectionViewFlowLayout()
- let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)

5. 저번에 스크롤뷰는 scrollView.frame = view.bounds이걸로 따로 크기 잡아주지 않더라도 view 전체에 깔렸었는데 UICollectionView(frame: view.bounds, collectionViewLayout: layout)하닌깐 에러
- UIScreen.main.bounds로 바꿔 써주니 됨 

6. 디바이스가 다크모드인지 아닌지 확인할 때 
- traitCollection.userInterfaceStyle = .dark
- override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        // 테마가 바뀔때마다 자동으로 호출되는 함수  
}

7. 컬렉션셀을 따로 파일을 만들었는데 컬렉션뷰에 등록을 시켜줘야 화면에 띄울수 있음
- collectionView.register(PokemonCell.self, forCellWithReuseIdentifier: "PokemonCell") 등록
- 

8. collectionView.register(PokemonCell.self, forCellWithReuseIdentifier: cellIdentifier)
- 이걸 ""문자열로 선언하면 틀리기 쉬우닌깐 인스턴스로 선언하려했지만 private let collectionView 안에서는 되지 않았다.
- viewDidLoad에 적어주닌깐 되었음
- class 밖에 전역으로 설정해주닌깐 인스턴스로 설정 가능했음 🤗

9. UIViewController가 메인인 뷰에 아래에 extension으로 UICollectionViewController 상속하려는데 Inheritance from non-protocol type 'UICollectionViewController' 에러 발생
- UICollectionViewDataSource를 상속했더니 Collection의 기능을 사용할 수 있었음

10. collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PokemonCell
- for: indexPath:이 함수에서 전달받은 indexPath

11. extension으로 델리게이트 기능 다 명시해 줬는데 에러는 나지 않지만 구현이 안되었음
- delegate만 구현해줬는데 extension에 dataSource까지 2개가 구현되어있으므로 dataSource도 구현해 줘야 했던거임 
- collectionView.delegate = self, collectionView.dataSource = self
12. Anchor의 multiple을 주는 방법은 알고 있었지만 snapKit은 몰랐기에 해매더라도 해결방법을 찾음(1시간 걸림 현타옴...)
- make.height.equalTo(self.snp.height).multipliedBy(0.7)
- equalTo에 0.7 넣고 아주 그냥 개판이였음 콜렉션뷰 셀을 가르키는게 self.snp.height 일줄이야...
- 여기다가 width값 넣어주니 방향 안 잡아줘도 cell에 알아서 들어갔음
