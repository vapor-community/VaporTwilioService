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

        /// Failed authentication
        case authenticationFailed

        /// Failed to send email (with error message)
        case unableToSendEmail(ErrorResponse)

        /// Generic error
        case unknownError(Response)

        /// Identifier
        public var identifier: String {
            switch self {
            case .encodingProblem:
                return "mailgun.encoding_error"
            case .authenticationFailed:
                return "mailgun.auth_failed"
            case .unableToSendEmail:
                return "mailgun.send_email_failed"
            case .unknownError:
                return "mailgun.unknown_error"
            }
        }

        /// Reason
        public var reason: String {
            switch self {
            case .encodingProblem:
                return "Encoding problem"
            case .authenticationFailed:
                return "Failed authentication"
            case .unableToSendEmail(let err):
                return "Failed to send email (\(err.message))"
            case .unknownError:
                return "Generic error"
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
    ///   - apiKey: API key including "key-" prefix
    ///   - domain: API domain
    public init(accountId: String, accountSecret: String) {
        self.accountId = accountId
        self.accountSecret = accountSecret
    }

    // MARK: Send message

    /// Send message
    ///
    /// - Parameters:
    ///   - content: Message
    ///   - container: Container
    /// - Returns: Future<Response>
    public func send(_ sms: OutgoingSMS, on container: Container) throws -> Future<Response> {
        let authKeyEncoded = try encode(accountId: self.accountId, accountSecret: self.accountSecret)

        var headers = HTTPHeaders([])
        headers.add(name: HTTPHeaderName.authorization, value: "Basic \(authKeyEncoded)")

        return try container.client().post(
            "https://api.twilio.com/2010-04-01/Accounts/\(self.accountId)/Messages.json",
            headers: headers
        ) { request in
            let text = OutgoingSMS(
                body: "Hello!",
                from: "+18316100806",
                to: "+14083688346"
            )

            try request.content.encode(text, as: MediaType.urlEncodedForm)
        }
    }
}

// MARK: Private

fileprivate extension Twilio {
    func encode(accountId: String, accountSecret: String) throws -> String {
        guard let apiKeyData = "\(accountId):\(accountSecret)".data(using: .utf8) else {
            throw ""
        }
        let authKey = apiKeyData.base64EncodedData()
        guard let authKeyEncoded = String.init(data: authKey, encoding: .utf8) else {
            throw ""
        }

        return authKeyEncoded
    }
}

extension String: Error { }
