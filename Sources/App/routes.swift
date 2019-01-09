import Vapor
import Twilio

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    //(831) 610-0806
    router.get { req -> Future<Response> in
        let twilio = try req.make(Twilio.self)

        let sms = OutgoingSMS(body: "Hey There", from: "+18316100806", to: "+14083688346")

        return try twilio.send(sms, on: req)
    }
}


