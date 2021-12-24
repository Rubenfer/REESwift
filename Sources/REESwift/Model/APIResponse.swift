import Foundation

struct APIResponse: Codable {
    let data: Data
    let included: [Included]
    
    struct Data: Codable {
        let type: String?
        let id: String?
        let attributes: Attributes?
    }
    
    struct Included: Codable {
        let type: String?
        let id: String?
        let groupId: String?
        let attributes: Attributes?
    }
    
    struct Attributes: Codable {
        let title: String?
        let lastUpdate: Date?
        let description: String?
        let color: String?
        let type: String?
        let magnitude: String?
        let composite: Bool?
        let values: [Value]?
        
        private enum CodingKeys : String, CodingKey {
            case title
            case lastUpdate = "last-update"
            case description
            case color
            case type
            case magnitude
            case composite
            case values
        }
        
        struct Value: Codable {
            let value: Float
            let percentage: Float?
            let datetime: Date
        }
    }
}
