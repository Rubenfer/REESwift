import Foundation
import Combine

public struct REESwift {
    
    public init() { }
    
}

public extension REESwift {
    
    func consumerPrices(startDate: Date, endDate: Date, geo: GEO, completion: @escaping (Result<[Value], Error>) -> Void) {
        prices(id: "1001", startDate: startDate, endDate: endDate, geo: geo, completion: completion)
    }
    
    func consumerPrices(date: Date, geo: GEO, completion: @escaping (Result<[Value], Error>) -> Void) {
        prices(id: "1001", startDate: date.start, endDate: date.end, geo: geo, completion: completion)
    }
    
    func consumerPrices(startDate: Date, endDate: Date, geo: GEO) -> AnyPublisher<[Value], Error> {
        return prices(id: "1001", startDate: startDate, endDate: endDate, geo: geo)
    }
    
    func consumerPrices(date: Date, geo: GEO) -> AnyPublisher<[Value], Error> {
        return prices(id: "1001", startDate: date.start, endDate: date.end, geo: geo)
    }
    
    func spotPrices(startDate: Date, endDate: Date, completion: @escaping (Result<[Value], Error>) -> Void) {
        prices(id: "600", startDate: startDate, endDate: endDate, geo: nil, completion: completion)
    }
    
    func spotPrices(date: Date, completion: @escaping (Result<[Value], Error>) -> Void) {
        prices(id: "600", startDate: date.start, endDate: date.end, geo: nil, completion: completion)
    }
    
    func spotPrices(startDate: Date, endDate: Date) -> AnyPublisher<[Value], Error> {
        return prices(id: "600", startDate: startDate, endDate: endDate, geo: nil)
    }
    
    func spotPrices(date: Date) -> AnyPublisher<[Value], Error> {
        return prices(id: "600", startDate: date.start, endDate: date.end, geo: nil)
    }
    
    private func prices(id: String, startDate: Date, endDate: Date, geo: GEO?, completion: @escaping (Result<[Value], Error>) -> Void) {
        let endpoint = Endpoint.prices(startDate: startDate, endDate: endDate, geo: geo)
        Network.shared.request(endpoint) { (result: Result<APIResponse, Error>) in
            switch result {
            case .success(let apiResponse):
                let prices = apiResponse.included.first { $0.id == id }
                guard let values = prices?.attributes?.values, !values.isEmpty else { completion(.failure(URLError(.badServerResponse))); return }
                completion(.success(values))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func prices(id: String, startDate: Date, endDate: Date, geo: GEO?) -> AnyPublisher<[Value], Error> {
        let endpoint = Endpoint.prices(startDate: startDate, endDate: endDate, geo: geo)
        return Network.shared.request(endpoint)
            .tryMap { (apiResponse: APIResponse) -> [APIResponse.Attributes.Value] in
                let prices = apiResponse.included.first { $0.id == id }
                guard let values = prices?.attributes?.values, !values.isEmpty else { throw URLError(.badServerResponse) }
                return values
            }
            .eraseToAnyPublisher()
    }
    
}
