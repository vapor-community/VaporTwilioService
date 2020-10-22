import Vapor

public struct LookupResponse: Content {
    let countryCode: String
    let phoneNumber: String
    let nationalFormat: String
    let carrier: CarrierResponse
}
