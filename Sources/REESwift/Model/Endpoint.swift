import Foundation

struct Endpoint {
    var path: String
    var queryItems: [URLQueryItem] = []
}

extension Endpoint {
    var url: URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "apidatos.ree.es"
        components.path = "/" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure("Invalid URL components: \(components)")
        }
        
        return url
    }
}

extension Endpoint {
    
    static func prices(startDate: Date, endDate: Date, geo: GEO?) -> Self {
        var queryItems = [
            URLQueryItem(name: "start_date", value: startDate.formatted),
            URLQueryItem(name: "end_date", value: endDate.formatted),
            URLQueryItem(name: "time_trunc", value: "hour")
        ]
        if let geo = geo {
            queryItems.append(URLQueryItem(name: "geo_ids", value: String(geo.id)))
        }
        return Endpoint(
            path: "es/datos/mercados/precios-mercados-tiempo-real",
            queryItems: queryItems
        )
    }
    
}
