import Foundation

protocol KeyValueStorage {
    func set(_ value: Any?, forKey key: String)
    func string(forKey key: String) -> String?
    func bool(forKey key: String) -> Bool
}
