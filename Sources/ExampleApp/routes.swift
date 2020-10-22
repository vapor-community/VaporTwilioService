import Vapor
import Twilio

/// Register your application's routes here.
func routes(_ app: Application) throws {
    // Basic "It works" example
    //(831) 610-0806
    app.get { req -> EventLoopFuture<ClientResponse> in
        let sms = OutgoingSMS(body: "Hey There", from: "+18316100806", to: "+14083688346")

        return req.twilio.send(sms)
    }

    app.get("lookup") { req -> EventLoopFuture<LookupResponse> in
        let phoneNumber = "+41 (0) 79 226 42 28"//"+18316100806"
        return req.twilio.lookup(phoneNumber)
    }

    app.post("incoming") { req -> Response in
        let sms = try req.content.decode(IncomingSMS.self)

        let responseMessage = SMSResponse(
            Message(body: "Hello Friend!"),
            Message(body: "This is a second text.")
        )

        return req.twilio.respond(with: responseMessage)
    }
}


