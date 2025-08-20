import UIKit

final class RegistrationRouter: RegistrationRouterInput {
    weak var viewController: UIViewController?

    func openMain() {
        guard let nav = viewController?.navigationController else { return }
        let storage = UserDefaultsStorage()
        let apiClient = URLSessionAPIClient()
        let main = ModuleBuilder.buildMainModule(storage: storage, apiClient: apiClient)
        nav.setViewControllers([main], animated: true)
    }
}
