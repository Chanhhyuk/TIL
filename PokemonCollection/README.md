# PokemonCollection
- extension과 static을 이용해서 전역적으로 사용할 color 생성
- 네비게이션에 버튼을 생성했는데 얘가 기본색이 link색이였다 그래서 씬 델리게이트에서 UIButton.appearance().tintColor = .systemBackground 값을줌

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
