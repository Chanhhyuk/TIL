# Messenger

1. Getting Started
- Models, Views, Controller, Resources 폴더로 나눔
- Resources 폴더에는 SceneDelegate, AppDelegate
- View에는 Storyboard, Assets, LaunchScreen
- 나머지 내가 코드 짤 부분은 Controllers 폴더에.

2. Log In & Register Screens
- main뷰(conversations)에서 로그인 여부 확인하고 로그인 안되었으면 로그인 뷰로 넘어가게끔 설정
- 로그인 뷰로 바로 넘어가야 되는데 애니메이션을 줄 경우 메인화면이 살짝 나오면서 로그인 뷰로 가짐 그래서 animate false
- ⭐️present에 바로 loginView 주는게 아니라 UINavigationController(rootViewController: vc) 줌
- scrollView.clipsToBounds = true         // 스크롤뷰에 속해있는 나머지 subview가 짤리지 않게 방지
- imageView.contentMode = .scaleAspectFit // 이미지를 비율에 맞게 늘린다.
- ⭐️UITapGestureRecognizer: 버튼말고 이미지뷰 같은거에 탭 인식하게 만들기
let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic))
imageView.addGestureRecognizer(gesture)
- ⭐️imageView.isUserInteractionEnabled = true // 이것도 같이줘야 하는데 왜 줘야 하는지는 모름

3. Taking or Choosing Profile Picture
- imageView.layer.masksToBounds = true // 이거 사용하지 않으면 imageView안에 image가 예쁘게 잘리지 않고 그대로 나옴
- imageView.layer.cornerRadius = imageView.width / 2.0 이미지뷰 동그랗게 만들때 이렇게 사용했는데 anchor를 사용할때는 어떻게 해야할까?
- 사진찍기,앨범과 관련해서 UIImagePickerControllerDelegate을 사용
- Info.Plist가서 privacy 카메라,앨범 허용

4. Set Up Firebase & Email/Pass Log In
- Firebase 웹에서로그인 기능을 추가
- Firebase 셋팅함, Appdelegate에서 FirebaseApp.configure() 설정
- Firebase의 회원정보를 가져오거나 입력해야 하는 뷰인 로그인뷰와 회원가입뷰와 FirebaseAuth 설정 
- 회원가입시 이름,이메일,비밀번호,프로필사진이 저장되어야 할것을 인지

5. Database Set Up
6. Facebook Login & Log Out
- 스토리보드 탭바,네비게이션 컨트롤러 추가

8. Building User Interface & Dependencies
- 라이브러리 설치
messageKit: 채팅 대화방의 말풍선이나 프로필 등을 쉽게 구현할 수 있음
JGProgressHUD: 로딩 팝업 등을 쉽고 예쁘게 보여줄 수 있는 라이브러리
RealmSwift: 데이터 모델을 따로 만들지 않고도 리액티비 데이터 레이어를 쉽게 구현할 수 있다
SDWebImage: url 방식으로 이미지나 영상을 받아올때 비동기적으로 처리하고 받아온 이미지나 영상을 캐싱하여 사용할 수 있게 해준다(속도문제 개선)
- tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell") 사용
register: 셀을 등록하는데 사용하는 메서드
dequeueReusableCell: 셀 재사용시 사용하는 메서드
reuseIdentifier: 셀의 id
NibName: 셀의 NibNam  // xib를 가르킴 xib 파일을 사용하지 않으면 사용하지 않는다.

- 네비게이션 타이틀 자리에 서치바
navigationController?.navigationBar.topItem?.titleView = searchBar

- Cancel 버튼을 누르면 전 네이게이션으로 돌아갈 때 이렇게 이벤트를 줌
navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: .done, target: self, action: #selector(dismissSelf))
@objc private func dismissSelf() {
    dismiss(animated: true, completion: nil)
}

9. Upload Photos to Firebase Storage
- Firebase/Storage 추가
10. Fetching Users & Photos
- 