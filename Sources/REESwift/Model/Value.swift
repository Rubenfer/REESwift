import Foundation

public protocol Value {
    var datetime: Date { get }
    var value: Float { get }
}

extension APIResponse.Attributes.Value: Value { }
