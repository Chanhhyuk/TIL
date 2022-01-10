# InstargramBeta

## Part 1
- MVC 패턴으로 폴더를 나눈다
- ViewController 중에서 앱의 핵심적인 컨트롤러만 따로 관리하기 위해 Core Tabs 폴더 생성
- 스토리보드를 사용해서 네비게이션컨트롤러, 탭바 컨트롤러를 만들고 탭바 아이콘을 설정함

## Part 2
- firebase 설치
- firebase ios 생성후 받은 구글시트 resource 폴더에 적용
- AppDelegate에 import Firebase 후 FirebaseApp.configure() 설정 
- 코드가 지저분해질것을 대비해 데이터 파일을 따로 Resouce에 만듬
- 인스턴스를 하나만 사용할거여서 static 선언을 함
- view.addSubview를 viewDidLoad()에다가 도배했었는데 그것마저 addSubview() 함수를 만들어서 사용 viewDidLoad가 더 깔끔해짐
