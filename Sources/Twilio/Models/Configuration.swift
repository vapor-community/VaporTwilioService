import Vapor

public struct TwilioConfiguration {
    public let accountId: String
    public let accountSecret: String
    
    /// Initializer
    ///
    /// - Parameters:
    ///   - accountId: Account ID provided by Twilio
    ///   - accountSecret: Account secret provided by Twilio
    public init(accountId: String, accountSecret: String) {
        self.accountId = accountId
        self.accountSecret = accountSecret
    }
    
    /// It will try to initialize configuration with environment variables:
    /// - TWILIO_ACCOUNT_ID
    /// - TWILIO_ACCOUNT_SECRET
    public static var environment: TwilioConfiguration {
        guard
            let accountId = Environment.get("TWILIO_ACCOUNT_ID"),
            let accountSecret = Environment.get("TWILIO_ACCOUNT_SECRET")
            else {
            fatalError("Mailgun environmant variables not set")
        }
        return .init(accountId: accountId, accountSecret: accountSecret)
    }
}
