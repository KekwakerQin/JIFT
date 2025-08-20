import Foundation

final class MainPresenter: MainViewOutput, MainInteractorOutput {
    private weak var view: MainViewInput?
    private let interactor: MainInteractorInput
    private let router: MainRouterInput

    init(view: MainViewInput, interactor: MainInteractorInput, router: MainRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    // MARK: - ViewOutput

    func viewDidLoad() {
        interactor.loadProducts()
    }

    func didTapGreeting() {
        let name = interactor.loadUserName() ?? "пользователь"
        view?.showGreeting("Рад тебя видеть, \(name)!")
    }

    // MARK: - InteractorOutput

    func didLoad(products: [Product]) {
        view?.showProducts(products)
    }

    func didFailToLoad(error: Error) {
        view?.showError("Не удалось загрузить данные. Попробуйте позже.")
    }
}
