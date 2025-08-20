import UIKit

enum ModuleBuilder {
    static func buildRegistrationModule(storage: KeyValueStorage, apiClient: APIClient) -> UIViewController {
        let vc = RegistrationViewController()
        let interactor = RegistrationInteractor(storage: storage, validator: RegistrationValidator())
        let router = RegistrationRouter()
        let presenter = RegistrationPresenter(view: vc, interactor: interactor, router: router)

        vc.output = presenter
        interactor.output = presenter
        router.viewController = vc
        return vc
    }

    static func buildMainModule(storage: KeyValueStorage, apiClient: APIClient) -> UIViewController {
        let vc = MainViewController()
        let interactor = MainInteractor(apiClient: apiClient, storage: storage)
        let router = MainRouter()
        let presenter = MainPresenter(view: vc, interactor: interactor, router: router)

        vc.output = presenter
        interactor.output = presenter
        router.viewController = vc
        return vc
    }
}
