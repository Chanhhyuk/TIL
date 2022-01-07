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
