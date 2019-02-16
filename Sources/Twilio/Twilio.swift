import Vapor

public protocol TwilioProvider: Service {
    var accountId: String { get }
    var accountSecret: String { get }
    func send(_ sms: OutgoingSMS, on container: Container) throws -> Future<Response>
}

// MARK: - Engine
public struct Twilio: TwilioProvider {
    public enum Error: Debuggable {
        /// Encoding problem
        case encodingProblem

        /// Identifier
        public var identifier: String {
            switch self {
            case .encodingProblem:
                return "twilio.encoding_error"
            }
        }

        /// Reason
        public var reason: String {
            switch self {
            case .encodingProblem:
                return "Encoding problem"
            }
        }
    }

    /// Error response object
    public struct ErrorResponse: Decodable {

        /// Error messsage
        public let message: String
    }

    public var accountId: String
    public var accountSecret: String

    /// Initializer
    ///
    /// - Parameters:
    ///   - accountId: Account ID provided by Twilio
    ///   - accountSecret: Account secret provided by Twilio
    public init(accountId: String, accountSecret: String) {
        self.accountId = accountId
        self.accountSecret = accountSecret
    }

    // MARK: Send message

    /// Send sms
    ///
    /// - Parameters:
    ///   - content: outgoing sms
    ///   - container: Container
    /// - Returns: Future<Response>
    public func send(_ sms: OutgoingSMS, on container: Container) throws -> Future<Response> {
        let authKeyEncoded = try encode(accountId: self.accountId, accountSecret: self.accountSecret)

        var headers = HTTPHeaders([])
        headers.add(name: HTTPHeaderName.authorization, value: "Basic \(authKeyEncoded)")

        let client: Client = try container.make()
        return client.post(
            "https://api.twilio.com/2010-04-01/Accounts/\(self.accountId)/Messages.json",
            headers: headers
        ) { request in
            try request.content.encode(sms, as: MediaType.urlEncodedForm)
        }
    }

    public func respond(with response: SMSResponse, on req: Request) -> Response {
        return req.response(response.generateTwiml(), as: MediaType.xml)
    }
    
    public func longResponse(
        incomingSMS: IncomingSMS,
        outgoingMessages: [String],
        on req: Request
    ) throws -> Future<Response> {
        return try outgoingMessages
            .map { OutgoingSMS(body: $0, from: incomingSMS.to, to: incomingSMS.from) }
            .map { try self.send($0, on: req) }
            .flatten(on: req)
            .transform(to: req.response(SMSResponse().generateTwiml(), as: MediaType.xml))
    }
}

// MARK: Private

fileprivate extension Twilio {
    func encode(accountId: String, accountSecret: String) throws -> String {
        guard let apiKeyData = "\(accountId):\(accountSecret)".data(using: .utf8) else {
            throw Error.encodingProblem
        }
        let authKey = apiKeyData.base64EncodedData()
        guard let authKeyEncoded = String.init(data: authKey, encoding: .utf8) else {
            throw Error.encodingProblem
        }

        return authKeyEncoded
    }
}
