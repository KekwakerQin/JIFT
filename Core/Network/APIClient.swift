import Foundation

protocol APIClient {
    func get(_ url: URL, completion: @escaping (Result<Data, Error>) -> Void)
}
