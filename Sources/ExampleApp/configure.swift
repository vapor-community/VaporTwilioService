import Vapor
import Twilio

/// Called before your application initializes.
public func configure(_ app: Application) throws {
    app.twilio.configuration = .environment
    
    try routes(app)
}
