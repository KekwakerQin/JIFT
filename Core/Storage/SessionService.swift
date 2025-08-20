import Foundation

struct SessionService {
    private let storage: KeyValueStorage

    init(storage: KeyValueStorage) {
        self.storage = storage
    }

    var isRegistered: Bool {
        storage.bool(forKey: Keys.isRegistered)
    }

    func saveUser(name: String) {
        storage.set(name, forKey: Keys.userName)
        storage.set(true, forKey: Keys.isRegistered)
    }

    func loadUserName() -> String? {
        storage.string(forKey: Keys.userName)
    }
}

enum Keys {
    static let userName = "userName"
    static let isRegistered = "isRegistered"
}
