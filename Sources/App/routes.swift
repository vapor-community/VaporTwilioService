import Vapor
import Twilio

/*
 ToCountry=US
 ToState=CA&
 SmsMessageSid=SMd52103a686c7dbe6787f44892f6a696e
 NumMedia=0&
 ToCity=BOULDER+CREEK&
 FromZip=94087&
 SmsSid=SMd52103a686c7dbe6787f44892f6a696e&
 FromState=CA&
 SmsStatus=received&
 FromCity=SUNNYVALE&
 Body=Hey&
 FromCountry=US&
 To=%2B18316100806&
 ToZip=95006&
 NumSegments=1&
 MessageSid=SMd52103a686c7dbe6787f44892f6a696e&
 AccountSid=AC6d572f28f8d1780b3970b962a876fd71&
 From=%2B14083688346&
 ApiVersion=2010-04-01
 */

public struct IncomingSMS: Content {
    let toCountry: String
    let toState: String
    let smsMessageId: String
    let numMedia: Int
    let toCity: String
    let fromZip: Int
    let smsId: String
    let fromState: String
    let smsStatus: String // Make this an enum
    let fromCity: String
    let body: String
    let fromCountry: String
    let to: String
    let toZip: String
    let numSegments: Int
    let messageId: String
    let accountId: String
    let from: String
    let apiVersion: String // Make this a Date

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

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // Basic "It works" example
    //(831) 610-0806
    router.get { req -> Future<Response> in
        let twilio = try req.make(Twilio.self)

        let sms = OutgoingSMS(body: "Hey There", from: "+18316100806", to: "+14083688346")

        return try twilio.send(sms, on: req)
    }

    router.post("incoming") { (req) -> String in
        let sms = try req.content.syncDecode(IncomingSMS.self)
        return ""
    }
}


