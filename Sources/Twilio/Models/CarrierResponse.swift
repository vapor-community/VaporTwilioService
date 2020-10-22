import Vapor

public struct CarrierResponse: Content {

    enum CarrierType: String, Codable {
        case mobile
        case landline
        case voip
    }

    let name: String
    let type: CarrierType
}
