- MVVM(Model, View, ViewModel)외에 Controller,Utils과 API 폴더를 따로 만들어서 정리
- MARK: Properties, Lifecycle, configureUI, Selector, Extension(delegate 종류이름)
- without storyboard 셋팅 (스토리보드 설정에서 삭제 및 내가 만든 custom root viewController 연결)
- 굳이 사용해도 되지 않아도 되는 상수, typealias, cell이름 변수화, Protocol을 사용하여 필요성을 느낌
- 로딩바를 넣으므로써 좋은 사용자 경험을 준다


- 라이브러리 설치
- firebase 사용
- YPImagePicker :이미지를 다중으로 념겨야할때 사용
- messageKit: 채팅 대화방의 말풍선이나 프로필 등을 쉽게 구현할 수 있음
- JGProgressHUD: 로딩 팝업 등을 쉽고 예쁘게 보여줄 수 있는 라이브러리
- RealmSwift: 데이터 모델을 따로 만들지 않고도 리액티비 데이터 레이어를 쉽게 구현할 수 있다
- SDWebImage: url 방식으로 이미지나 영상을 받아올때 비동기적으로 처리하고 받아온 이미지나 영상을 캐싱하여 사용할 수 있게 해준다(속도문제 개선)
