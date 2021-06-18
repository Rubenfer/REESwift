import Foundation

public protocol PrecioLuzValue {
    var datetime: Date { get }
    var value: Float { get }
}

extension APIResponse.Attributes.Value: PrecioLuzValue { }
