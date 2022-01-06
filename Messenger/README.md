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

