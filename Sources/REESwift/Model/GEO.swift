public enum GEO {
    case peninsula
    case canarias
    case baleares
    case ceuta
    case melilla
}

extension GEO {
    var id: Int {
        switch self {
        case .peninsula: return 8741
        case .canarias: return 8742
        case .baleares: return 8743
        case .ceuta: return 8744
        case .melilla: return 8745
        }
    }
}
