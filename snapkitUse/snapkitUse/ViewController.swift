import UIKit
import SnapKit

class ViewController: UIViewController {
    private var target = UIView()
    private var targetBtn = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        target.backgroundColor = .red
        view.addSubview(target)
        // addSubview를 기준으로 왼쪽이 슈퍼뷰(부모뷰), 오른쪽이 서브뷰(자식뷰)
        // view는 개발자가 생성할수도 있지만 일반적으로 UIViewController의 view이다.
        
        targetBtn.setTitle("target", for: .normal)
        targetBtn.setTitleColor(.blue, for: .normal)

        target.snp.makeConstraints{ make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.top.equalTo(view.snp.top)  // 부모뷰의 top과 똑같이한다.
            make.top.equalToSuperview()     // 부모뷰의 top과 똑같이한다.
            make.top.equalTo(target.snp.bottom).offset(30)  // 30 간격
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.height)
        }
        
    }
    
    
}
