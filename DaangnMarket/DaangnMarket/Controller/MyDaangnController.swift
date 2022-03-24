import UIKit
import SnapKit

class MyDaangnController: UICollectionViewController{
    // MARK: Properties
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        collectionView.register(ProfileView.self, forCellWithReuseIdentifier: "cell")
    }
    
    // MARK: ConfigureUI
    private func configureUI(){
        navigationController?.navigationBar.backgroundColor = .yellow
        view.backgroundColor = .white
    }
    
}



// MARK: UICollectionViewDataSource
extension MyDaangnController {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let profileView = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProfileView
        return profileView
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
}

// MARK: UICollectionViewDelegate
extension MyDaangnController {
    
}


// MARK: UICollectionViewDelegateFlowLayout
extension MyDaangnController: UICollectionViewDelegateFlowLayout {

}
