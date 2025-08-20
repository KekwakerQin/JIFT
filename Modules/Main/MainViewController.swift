import UIKit

final class MainViewController: UIViewController, MainViewInput {
    weak var output: MainViewOutput?

    private let tableView = UITableView()
    private var items: [Product] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Главный экран"
        view.backgroundColor = .systemBackground
        configureTable()
        configureBar()
        output?.viewDidLoad()
    }

    private func configureTable() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func configureBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Приветствие", style: .plain, target: self, action: #selector(handleGreeting))
    }

    @objc private func handleGreeting() {
        output?.didTapGreeting()
    }

    // MARK: - MainViewInput

    func showProducts(_ products: [Product]) {
        items = products
        tableView.reloadData()
    }

    func showError(_ message: String) {
        let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
    }

    func showGreeting(_ text: String) {
        let alert = UIAlertController(title: "Привет!", message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default))
        present(alert, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { items.count }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let id = "cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: id) ?? UITableViewCell(style: .subtitle, reuseIdentifier: id)
        let p = items[indexPath.row]
        cell.textLabel?.text = p.title
        cell.detailTextLabel?.text = "€ \(p.price)"
        cell.detailTextLabel?.textColor = .secondaryLabel
        cell.selectionStyle = .none
        return cell
    }
}
