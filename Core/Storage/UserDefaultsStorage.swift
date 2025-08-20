import Foundation

struct UserDefaultsStorage: KeyValueStorage {
    private let defaults = UserDefaults.standard

    func set(_ value: Any?, forKey key: String) {
        defaults.setValue(value, forKey: key)
    }

    func string(forKey key: String) -> String? {
        defaults.string(forKey: key)
    }

    func bool(forKey key: String) -> Bool {
        defaults.bool(forKey: key)
    }
}
