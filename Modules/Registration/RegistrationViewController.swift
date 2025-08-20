import UIKit

final class RegistrationViewController: UIViewController, RegistrationViewInput {
    weak var output: RegistrationViewOutput?

    private let firstNameField = UITextField()
    private let lastNameField = UITextField()
    private let birthDatePicker = UIDatePicker()
    private let passwordField = UITextField()
    private let confirmField = UITextField()
    private let registerButton = UIButton(type: .system)

    private let errorLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("We are here")
        title = "Регистрация"
        view.backgroundColor = .systemBackground
        configureUI()
        output?.viewDidLoad()
    }

    private func configureUI() {
        firstNameField.placeholder = "Имя"
        lastNameField.placeholder = "Фамилия"
        passwordField.placeholder = "Пароль"
        confirmField.placeholder = "Подтверждение пароля"
        passwordField.isSecureTextEntry = true
        confirmField.isSecureTextEntry = true

        birthDatePicker.datePickerMode = .date
        birthDatePicker.preferredDatePickerStyle = .wheels
        birthDatePicker.maximumDate = Date()

        registerButton.setTitle("Регистрация", for: .normal)
        registerButton.isEnabled = true

        errorLabel.numberOfLines = 0
        errorLabel.textColor = .systemRed
        errorLabel.font = .systemFont(ofSize: 13)

        let stack = UIStackView(arrangedSubviews: [
            firstNameField, lastNameField, birthDatePicker,
            passwordField, confirmField, registerButton, errorLabel
        ])
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16)
        ])

        [firstNameField, lastNameField, passwordField, confirmField].forEach { tf in
            tf.addTarget(self, action: #selector(handleEditingChanged), for: .editingChanged)
        }
        birthDatePicker.addTarget(self, action: #selector(handleEditingChanged), for: .valueChanged)
        registerButton.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
    }

    @objc private func handleEditingChanged() {
        output?.didChangeFields(
            firstName: firstNameField.text ?? "",
            lastName: lastNameField.text ?? "",
            birthDate: birthDatePicker.date,
            password: passwordField.text ?? "",
            confirm: confirmField.text ?? ""
        )
    }

    @objc private func handleRegister() {
        output?.didTapRegister(
            firstName: firstNameField.text ?? "",
            lastName: lastNameField.text ?? "",
            birthDate: birthDatePicker.date,
            password: passwordField.text ?? "",
            confirm: confirmField.text ?? ""
        )
    }

    // MARK: - RegistrationViewInput

    func updateRegisterButton(isEnabled: Bool) {
        registerButton.isEnabled = isEnabled
    }

    func showErrors(_ errors: [RegistrationValidator.FieldError]) {
        errorLabel.text = errors.map(mapError).joined(separator: "\n")
    }

    private func mapError(_ e: RegistrationValidator.FieldError) -> String {
        switch e {
        case .firstNameTooShort: return "Имя должно содержать не менее 2 символов."
        case .lastNameTooShort: return "Фамилия должна содержать не менее 2 символов."
        case .passwordTooWeak: return "Пароль должен иметь ≥6 символов, 1 заглавную букву и цифру."
        case .passwordsDoNotMatch: return "Пароли не совпадают."
        case .tooYoung(let min): return "Возраст должен быть не менее \(min) лет."
        }
    }
}
