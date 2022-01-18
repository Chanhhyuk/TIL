import UIKit
import SnapKit

class MainController: UIViewController {
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(PokemonCell.self, forCellWithReuseIdentifier: "PokemonCell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        title = "포켓몬도감"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(searchTap))
    }
    
    
    @objc private func searchTap(){
    
    }
    private func addView(){
        view.addSubview(collectionView)
    }
    
}
