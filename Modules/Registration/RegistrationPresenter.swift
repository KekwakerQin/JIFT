import Foundation

final class RegistrationPresenter: RegistrationViewOutput, RegistrationInteractorOutput {
    private weak var view: RegistrationViewInput?
    private let interactor: RegistrationInteractorInput
    private let router: RegistrationRouterInput

    private var lastInput: RegistrationValidator.Input?

    init(view: RegistrationViewInput, interactor: RegistrationInteractorInput, router: RegistrationRouterInput) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }

    // MARK: - ViewOutput

    func viewDidLoad() { }

    func didChangeFields(firstName: String, lastName: String, birthDate: Date, password: String, confirm: String) {
        let input = RegistrationValidator.Input(firstName: firstName, lastName: lastName, birthDate: birthDate, password: password, confirmPassword: confirm)
        lastInput = input
        interactor.validate(input: input)
    }

    func didTapRegister(firstName: String, lastName: String, birthDate: Date, password: String, confirm: String) {
        let input = RegistrationValidator.Input(firstName: firstName, lastName: lastName, birthDate: birthDate, password: password, confirmPassword: confirm)
        interactor.validate(input: input)
    }

    // MARK: - InteractorOutput

    func didValidate(errors: [RegistrationValidator.FieldError]) {
        let isValid = errors.isEmpty
        view?.updateRegisterButton(isEnabled: inputIsFilled(lastInput) && isValid)
        view?.showErrors(errors)

        if isValid, let input = lastInput {
            interactor.saveUser(name: input.firstName)
        }
    }

    func didSaveUser() {
        router.openMain()
    }

    // MARK: - Helpers

    private func inputIsFilled(_ input: RegistrationValidator.Input?) -> Bool {
        guard let input = input else { return false }
        return !input.firstName.isEmpty &&
               !input.lastName.isEmpty &&
               !input.password.isEmpty &&
               !input.confirmPassword.isEmpty
    }
}
