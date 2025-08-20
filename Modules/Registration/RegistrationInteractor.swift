import Foundation

final class RegistrationInteractor: RegistrationInteractorInput {
    weak var output: RegistrationInteractorOutput?

    private let storage: KeyValueStorage
    private let validator: RegistrationValidator

    init(storage: KeyValueStorage, validator: RegistrationValidator) {
        self.storage = storage
        self.validator = validator
    }

    func validate(input: RegistrationValidator.Input) {
        let errors = validator.validate(input)
        output?.didValidate(errors: errors)
    }

    func saveUser(name: String) {
        let session = SessionService(storage: storage)
        session.saveUser(name: name)
        output?.didSaveUser()
    }
}
