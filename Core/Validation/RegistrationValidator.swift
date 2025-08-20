import Foundation

struct RegistrationValidator {
    struct Input {
        let firstName: String
        let lastName: String
        let birthDate: Date
        let password: String
        let confirmPassword: String
    }

    enum FieldError: Error, Equatable {
        case firstNameTooShort
        case lastNameTooShort
        case passwordTooWeak
        case passwordsDoNotMatch
        case tooYoung(minAge: Int)
    }

    func validate(_ input: Input) -> [FieldError] {
        var errors: [FieldError] = []
        if input.firstName.trimmingCharacters(in: .whitespacesAndNewlines).count < 2 {
            errors.append(.firstNameTooShort)
        }
        if input.lastName.trimmingCharacters(in: .whitespacesAndNewlines).count < 2 {
            errors.append(.lastNameTooShort)
        }
        if isTooYoung(input.birthDate, min: 14) {
            errors.append(.tooYoung(minAge: 14))
        }
        if !isStrongPassword(input.password) {
            errors.append(.passwordTooWeak)
        }
        if input.password != input.confirmPassword {
            errors.append(.passwordsDoNotMatch)
        }
        return errors
    }

    // MARK: - Helpers

    private func isTooYoung(_ date: Date, min: Int) -> Bool {
        let calendar = Calendar.current
        guard let minDate = calendar.date(byAdding: .year, value: -min, to: Date()) else { return true }
        return date > minDate
    }

    private func isStrongPassword(_ pwd: String) -> Bool {
        let hasUpper = pwd.range(of: "[A-Z]", options: .regularExpression) != nil
        let hasDigit = pwd.range(of: "[0-9]", options: .regularExpression) != nil
        return pwd.count >= 6 && hasUpper && hasDigit
    }
}
