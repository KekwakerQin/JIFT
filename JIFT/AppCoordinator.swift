import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private let storage: KeyValueStorage
    private let apiClient: APIClient

    init(window: UIWindow, storage: KeyValueStorage, apiClient: APIClient) {
        self.window = window
        self.storage = storage
        self.apiClient = apiClient
    }

    func start() {
        let isRegistered = SessionService(storage: storage).isRegistered
        let rootVC: UIViewController

        if isRegistered {
            rootVC = ModuleBuilder.buildMainModule(storage: storage, apiClient: apiClient)
        } else {
            print("We are here on blackscreen")
            rootVC = ModuleBuilder.buildRegistrationModule(storage: storage, apiClient: apiClient)
        }

        let nav = UINavigationController(rootViewController: rootVC)
        window.rootViewController = nav
        window.makeKeyAndVisible()
    }

    func switchToMain() {
        let nav = window.rootViewController as? UINavigationController
        let main = ModuleBuilder.buildMainModule(storage: storage, apiClient: apiClient)
        nav?.setViewControllers([main], animated: true)
    }
}
