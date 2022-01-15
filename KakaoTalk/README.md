# KakaoTalk

## ⚙️ 구현해야할 것
- ✅ 스토리보드없이 네비게이션 컨트롤러, 탭바 컨트롤러 구현
- ✅ 각 탭마다 테이블뷰 구현
- 슬라이드 만들어보기
- tableView안에 collectionView 넣어보기
- 전화,기기내 저장, 주소록 권한 허용 만들기
- ❗️UI 위치잡기 (Snapkit 라이브러리 사용해보기)
- 카카오톡 로그인 API 엮기
- 심심이 API 엮기

## 🔨고칠것
- 더보기 탭 지갑 아래칸 바둑판모양 4x4 메뉴판 tableViewCell 하나 만들어서 그 위에다가 버튼 일일이 다 만들었는데
collectionView로 하면 더 깔끔하고 코드량도 훨씬 적어질듯
- 위와 같이 쇼핑탭의 맨위칸 버튼들도 컬렉션뷰로 만들고 테이블뷰 위에 깔기

## 💡배운것
- iOS 슬라이드의 대표적인 라이브러리 SWRevealViewController가 있지만 스토리보드를 사용하지 않으므로 무용지물이 됨
- 전체뷰 넓이에서 깔끔하게 좌우로 버튼을 4등분 하는 방법 widthAnchor.constraint(equalTo: topMenu.widthAnchor (기준이 될 width값) ,multiplier: 0.2(등분할 숫자) )
- UIViewController에다가 delegate 전부 붙여서 사용하는게 아닌 extension으로 아래 따로 만들어서 사용
- 버튼 누르면 view가 아래로 천천히 생겼다가 다시 누르면 천천히 위로 다시 사라지는걸 구현하려했다. 처음에는 슬라이드방식을 생각했는데 무슨 탭메뉴만 나오더라 다른방식으로 view의 높이를 줄였다가 높였다가 하닌깐 view만 생겼다가 없어질뿐 view안에 있는 텍스트는 그대로 있길래 isHidden으로 같이 숨기는 방법을 선택함
- 테이블뷰는 프레임 앵커로 일일이 잡을 필요 없이    'tableView.frame = view.bounds' 사용하면 뷰 전체로 UI가 잡힘



- 다음화면으로 넘어가는 처리(화면전환방식)
- 테이블뷰 구현 + 델리게이트 패턴 + 프로토콜