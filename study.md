아니 델리게이트도 viewDidLoad에다가 적는게 아니라 따로 함수에다가 넣어도 될듯?

- addTarget의 self가 현재의뷰(viewController)를 의미
- #selector(Viewcontroller.functionName)을 써야 하지만 self로 추론할수 있어서 ViewController 생략가능

tableview tableview나 collectionview에 있는 cell 들은 직접 조작해서는 안된다 (anchor로 위치조절 등)
tableView.dequeueReusableCell(withIdentifier: “cell”)
withIdentifier: 특정한 것을 지칭하려는 식별자
CALayer()
button.layer.masksToBounds = true
scrollView.frame = view.bounds
button.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)       // ? 왜 붙일까?


## 반복
- UITapGestureRecognizer: 버튼말고 이미지뷰 같은거에 탭 인식하게 만들기
let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapChangeProfilePic))
imageView.addGestureRecognizer(gesture)

- 유효성검사
guard let email = emailField.text, let password = passwordField.text, !email.isEmpty, !password.isEmpty, password.count >= 6 else {
        alertUserLoginError()
        return
}

- 알람
func alertUserLoginError() {    // 로그인 에러 알림창
        let alert = UIAlertController(title: "Woops", message: "Please enter all information to create a new account.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        present(alert, animated: true)
}


isUserInteractionEnabled: 두개를 동시에 누를때 눌릴수 있게끔?
imageView.isUserInteractionEnabled = true
scrollView.isUserInteractionEnabled = true

**strong 안주었을 시**
```swift
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let actionSheet = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { [weak self] _ in
            do {
                try FirebaseAuth.Auth.auth().signOut()
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)    //⭐️
                nav.modalPresentationStyle = .fullScreen
                present(nav, animated: true)
            }catch{
                print("Failed to log out")
            }
            
        }))
        
    }
```
**스트롱 주었을 시**
```swift
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let actionSheet = UIAlertController(title: "", message: "", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { [weak self] _ in
            
            guard let strongSelf = self else {
                return
            }
            
            do {
                try FirebaseAuth.Auth.auth().signOut()
                let vc = LoginViewController()
                let nav = UINavigationController(rootViewController: vc)    //⭐️
                nav.modalPresentationStyle = .fullScreen
                strongSelf.present(nav, animated: true)
            }catch{
                print("Failed to log out")
            }
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(actionSheet, animated: true)
        
    }
```
    

