public enum TwilioError: Error {
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
