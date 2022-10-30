
import UIKit

final class TableViewController: UIViewController {
    
    // MARK: Property
    private var users = [User]()
    private var viewModel = TableViewModel()
    
    // MARK: Views
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.alpha = 0.0
        return tableView
    }()
    
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    private lazy var fetchButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.setTitle("Загрузить", for: .normal)
        button.layer.cornerRadius = 15
        return button
    }()
    
    // MARK: Init
    init(viewModel : TableViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        layout()
    }
    // MARK: Private Methods
    private func setupViewModel() {
        viewModel.stateChanged = { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .initial:
                print("Initial")
            case .loading:
                self.activityIndicator.startAnimating()
            case .loaded(let users):
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    self.users = users
                    self.tableView.alpha = 1.0
                    self.tableView.reloadData()
                }
            case .error:
                ()
            }
        }
    }
    
    @objc func fetchAction() {
        viewModel.changeState(.viewIsReady)
    }
}

// MARK: UITableViewDataSource

extension TableViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        var content: UIListContentConfiguration = cell.defaultContentConfiguration()
        content.text = users[indexPath.row].name
        content.secondaryText = "Возраст \(users[indexPath.row].age) лет"
        cell.contentConfiguration = content
        return cell
    }
}

// MARK: UITableViewDelegate

extension TableViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.changeState(.cellDidTap)
    }
}

//MARK: Layout

private extension TableViewController {
    
    func layout() {
        
        view.addSubview(fetchButton)
        
        NSLayoutConstraint.activate([
            fetchButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            fetchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            fetchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
        ])
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            
            tableView.bottomAnchor.constraint(equalTo: fetchButton.topAnchor, constant: 30),
        ])
        
        view.addSubview(activityIndicator)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
