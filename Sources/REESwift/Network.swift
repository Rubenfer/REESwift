import Combine
import Foundation

class Network {
    
    static let shared = Network()
    
    private let decoder = JSONDecoder()
    
    private init() {
        decoder.dateDecodingStrategy = .custom { decoder in
            let container = try decoder.singleValueContainer()
            let dateString = try container.decode(String.self)
            let dateWithoutTimezone = String(dateString.dropLast(13))
            guard let date = DateFormatter.customFormatter.date(from: dateWithoutTimezone) else { throw URLError(.badServerResponse) }
            return date
        }
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<T, Error> {
        URLSession.shared
            .dataTaskPublisher(for: endpoint.url)
            .tryMap { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                          throw URLError(.badServerResponse)
                      }
                return element.data
            }
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: endpoint.url) { data, response, error in
            guard let data = data,
                  (response as? HTTPURLResponse)?.statusCode == 200,
                  error == nil
            else { completion(.failure(error ?? URLError(.badServerResponse))); return }
            do {
                let decodedData = try self.decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
    
}
