import UIKit
import SnapKit

// cell 등록할때 쓰일텐데 ""로 작성해서 틀릴수 있으니 미리적어두는 용도
private let cellIdentifier = "pokemonCell"

class MainController: UIViewController {
    
    // MARK: Properties
    
    var pokemon = [Pokemon]()
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .systemBackground
        collectionView.register(PokemonCell.self, forCellWithReuseIdentifier: cellIdentifier)
        return collectionView
    }()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        layout()
        fetchPokemon()
    }
    
    // MARK: Layout
    private func layout(){
        view.addSubview(collectionView)
        title = "포켓몬도감"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.search, target: self, action: #selector(searchTap))
    }
    
    
    // MARK: Selector
    @objc private func searchTap(){
    
    }
    
    // MARK: API
    private func fetchPokemon() {
        PokemonService.shared.fetchPokemons { (pokemon) in
            DispatchQueue.main.async {
                self.pokemon = pokemon
                self.collectionView.reloadData()        // reloadData는 only 메인쓰레드
            }
            
        }
    }
}


// MARK: Extension(Delegate, DataSource)

extension MainController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pokemon.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! PokemonCell
        cell.pokemon = pokemon[indexPath.item]
        return cell
    }
    
}

// MARK: Extension(FlowLayout)
extension MainController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - 36) / 3
        return CGSize(width: width, height: width)
    }
    
    // cell에 간격주기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 32, left: 8, bottom: 8, right: 8)
    }
}
