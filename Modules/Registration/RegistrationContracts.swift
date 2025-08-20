import UIKit

protocol RegistrationViewInput: AnyObject {
    func updateRegisterButton(isEnabled: Bool)
    func showErrors(_ errors: [RegistrationValidator.FieldError])
}

protocol RegistrationViewOutput: AnyObject {
    func viewDidLoad()
    func didChangeFields(firstName: String, lastName: String, birthDate: Date, password: String, confirm: String)
    func didTapRegister(firstName: String, lastName: String, birthDate: Date, password: String, confirm: String)
}

protocol RegistrationInteractorInput: AnyObject {
    func validate(input: RegistrationValidator.Input)
    func saveUser(name: String)
}

protocol RegistrationInteractorOutput: AnyObject {
    func didValidate(errors: [RegistrationValidator.FieldError])
    func didSaveUser()
}

protocol RegistrationRouterInput: AnyObject {
    func openMain()
}
