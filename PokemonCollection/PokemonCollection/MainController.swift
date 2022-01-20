import UIKit
import SnapKit

private let cellIdentifier = "pokemonCell"

class MainController: UIViewController {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(PokemonCell.self, forCellWithReuseIdentifier: cellIdentifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        title = "포켓몬도감"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(searchTap))
        collectionView.delegate = self
        collectionView.dataSource = self
        fetchPokemon()
        
    }
    private func fetchPokemon() {
        PokemonService.shared.fetchPokemons()
    }
    
    
    @objc private func searchTap(){
    
    }
    private func addView(){
        view.addSubview(collectionView)
    }
    
    
}

// 몇개의 셀을 또는 어떠한 셀을 보여줄것인지 대해서 함수정의
extension MainController: UICollectionViewDataSource,UICollectionViewDelegate {
    // n개의 셀을 보여주겠다
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    // 몇번째 아이템에 어떤 셀을 보여줄것인지
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PokemonCell
        return cell
    }
    
}

// 콜렉션뷰 레이아웃
extension MainController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 36) / 3
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 32, left: 8, bottom: 8, right: 8)
    }
}
