import UIKit

protocol MainViewInput: AnyObject {
    func showProducts(_ products: [Product])
    func showError(_ message: String)
    func showGreeting(_ text: String)
}

protocol MainViewOutput: AnyObject {
    func viewDidLoad()
    func didTapGreeting()
}

protocol MainInteractorInput: AnyObject {
    func loadProducts()
    func loadUserName() -> String?
}

protocol MainInteractorOutput: AnyObject {
    func didLoad(products: [Product])
    func didFailToLoad(error: Error)
}

protocol MainRouterInput: AnyObject { }
