import UIKit

private let homeCell = "homeCell"
private let plusCell = "plusCell"

class HomeController: UIViewController{
    // MARK: Propertiest
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(HomeCell.self, forCellReuseIdentifier: homeCell)
        return tableView
    }()
    
    private let plusButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.layer.cornerRadius = 25
        button.tintColor = .white
        button.backgroundColor = .orange
        button.addTarget(self, action: #selector(handlePlusButton), for: .touchUpInside)
        return button
    }()
    
    private let plusTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(PlusCell.self, forCellReuseIdentifier: plusCell)
        tableView.isHidden = true
        return tableView
    }()
    
    // MARK: Selector
    @objc private func handlePlusButton(){
        if plusButton.backgroundColor == .orange{
            UIView.animate(withDuration: 0.5, animations: {
                self.plusButton.backgroundColor = .white
                self.plusButton.tintColor = .black
                self.plusButton.setImage(UIImage(systemName: "xmark"), for: .normal)
                self.plusTableView.isHidden = false
                })
        } else {
            UIView.animate(withDuration: 0.5, animations: {
                self.plusButton.backgroundColor = .orange
                self.plusButton.tintColor = .white
                self.plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
                self.plusTableView.isHidden = true
            })
        }
    }
    @objc private func handleSearch(){
        let vc = SearchController()
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc private func handleCategory(){
        let vc = CategoryController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    @objc private func handleBell(){
        let vc = BellController()
        navigationController?.pushViewController(vc, animated: true)
    }
        
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        navi()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: ConfigureUI
    private func configureUI(){
        view.addSubview(tableView)
        tableView.frame = view.bounds
        view.addSubview(plusButton)
        plusButton.frame = CGRect(x: view.frame.width - 70 ,y: view.frame.height - 150 , width: 50, height: 50)
        view.addSubview(plusTableView)
        plusTableView.frame = CGRect(x: plusButton.frame.origin.x, y: view.frame.origin.y - 500, width: 100, height: 300)
        
    }
    
    private func navi(){
        let location = UIBarButtonItem(title: "부평동", style: .plain, target: nil, action: nil)
        let search = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(handleSearch))
        let category = UIBarButtonItem(image: UIImage(systemName: "list.bullet"), style: .plain, target: self, action: #selector(handleCategory))
        let bell = UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: #selector(handleBell))
        
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = location
        navigationItem.rightBarButtonItems = [bell,category,search]
    }
    
    
}

// MARK: Extension(UITalbeViewDataSource)
extension HomeController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: homeCell, for: indexPath) as! HomeCell
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(150)
    }
}


// MARK: Extension(UITableViewDelegate)
extension HomeController: UITableViewDelegate{
    
}
