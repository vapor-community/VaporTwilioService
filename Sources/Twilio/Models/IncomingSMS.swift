import Vapor

public struct IncomingSMS: Content {
    public let toCountry: String
    public let toState: String
    public let smsMessageId: String
    public let numMedia: Int
    public let toCity: String
    public let fromZip: Int
    public let smsId: String
    public let fromState: String
    public let smsStatus: String // Make this an enum
    public let fromCity: String
    public let body: String
    public let fromCountry: String
    public let to: String
    public let toZip: String
    public let numSegments: Int
    public let messageId: String
    public let accountId: String
    public let from: String
    public let apiVersion: String // Make this a Date

    public init(
        toCountry: String,
        toState: String,
        smsMessageId: String,
        numMedia: Int,
        toCity: String,
        fromZip: Int,
        smsId: String,
        fromState: String,
        smsStatus: String,
        fromCity: String,
        body: String,
        fromCountry: String,
        to: String,
        toZip: String,
        numSegments: Int,
        messageId: String,
        accountId: String,
        from: String,
        apiVersion: String
    ) {
        self.toCountry = toCountry
        self.toState = toState
        self.smsMessageId = smsMessageId
        self.numMedia = numMedia
        self.toCity = toCity
        self.fromZip = fromZip
        self.smsId = smsId
        self.fromState = fromState
        self.smsStatus = smsStatus
        self.fromCity = fromCity
        self.body = body
        self.fromCountry = fromCountry
        self.to = to
        self.toZip = toZip
        self.numSegments = numSegments
        self.messageId = messageId
        self.accountId = accountId
        self.from = from
        self.apiVersion = apiVersion
    }

    private enum CodingKeys: String, CodingKey {
        case toCountry = "ToCountry"
        case toState = "ToState"
        case smsMessageId = "SmsMessageSid"
        case numMedia = "NumMedia"
        case toCity = "ToCity"
        case fromZip = "FromZip"
        case smsId = "SmsSid"
        case fromState = "FromState"
        case smsStatus = "SmsStatus"
        case fromCity = "FromCity"
        case body = "Body"
        case fromCountry = "FromCountry"
        case to = "To"
        case toZip = "ToZip"
        case numSegments = "NumSegments"
        case messageId = "MessageSid"
        case accountId = "AccountSid"
        case from = "From"
        case apiVersion = "ApiVersion"
    }
}
