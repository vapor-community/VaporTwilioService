import Vapor

public struct LookupResponse: Content {
    public let countryCode: String
    public let phoneNumber: String
    public let nationalFormat: String
    public let carrier: CarrierResponse
}
