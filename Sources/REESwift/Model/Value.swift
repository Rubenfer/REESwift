import Foundation

public protocol Value: Codable {
    var datetime: Date { get }
    var value: Float { get }
}

extension APIResponse.Attributes.Value: Value { }
