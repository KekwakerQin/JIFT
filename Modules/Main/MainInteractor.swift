import Foundation

final class MainInteractor: MainInteractorInput {
    weak var output: MainInteractorOutput?

    private let apiClient: APIClient
    private let storage: KeyValueStorage

    init(apiClient: APIClient, storage: KeyValueStorage) {
        self.apiClient = apiClient
        self.storage = storage
    }

    func loadProducts() {
        guard let url = URL(string: "https://fakestoreapi.com/products") else { return }
        apiClient.get(url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                let products = self.decodeProducts(data)
                DispatchQueue.main.async {
                    self.output?.didLoad(products: products)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.output?.didFailToLoad(error: error)
                }
            }
        }
    }

    func loadUserName() -> String? {
        SessionService(storage: storage).loadUserName()
    }

    // MARK: - Helpers

    private func decodeProducts(_ data: Data) -> [Product] {
        do {
            return try JSONDecoder().decode([Product].self, from: data)
        } catch {
            return []
        }
    }
}
