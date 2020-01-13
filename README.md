
<a href="http://docs.vapor.codes/3.0/">
    <img src="http://img.shields.io/badge/read_the-docs-2196f3.svg" alt="Documentation">
</a>
<a href="https://discord.gg/vapor">
    <img src="https://img.shields.io/discord/431917998102675485.svg" alt="Team Chat">
</a>
<a href="LICENSE">
    <img src="http://img.shields.io/badge/license-MIT-brightgreen.svg" alt="MIT License">
</a>
<a href="https://circleci.com/gh/vapor/api-template">
    <img src="https://circleci.com/gh/vapor/api-template.svg?style=shield" alt="Continuous Integration">
</a>
<img src="https://img.shields.io/github/workflow/status/twof/VaporTwilioService/test" alt="Github Actions">
<a href="https://swift.org">
    <img src="http://img.shields.io/badge/swift-5.1-brightgreen.svg" alt="Swift 5.1">
</a>

# What

This is a wrapper service for interacting with the Twilio API for Vapor4
> Note: Vapor3 version is available in `vapor3` branch and from `1.0.0` tag

## Installation

```swift
  // dependencies
 .package(url: "https://github.com/twof/VaporTwilioService.git", from: "2.0.0")
 
  // Targets
  .target(name: "App", dependencies: ["Twilio"])
```

## Usage

### Setup
```swift
import Twilio

// Called before your application initializes.
func configure(_ app: Application) throws {
    /// case 1
    /// put into your environment variables the following keys:
    /// TWILIO_ACCOUNT_ID=...
    /// TWILIO_ACCOUNT_SECRET=...
    app.twilio.configuration = .environment

    /// case 2
    /// manually
    app.twilio.configuration = .init(accountId: "<account id>", accountSecret: "<account secret>")
}
```
### Sending a text
```swift
import Twilio

func routes(_ app: Application) throws {
    app.get { req -> EventLoopFuture<ClientResponse> in
        let sms = OutgoingSMS(body: "Hey There", from: "+18316100806", to: "+14083688346")
        return req.twilio.send(sms)
    }
}
```

### Handling Incoming Texts
After [setting up the necessary routing within your Twilio account](https://www.twilio.com/docs/sms/twiml#twilios-request-to-your-application), you may create routes to handle and respond to incoming texts.

```swift
import Twilio

func routes(_ app: Application) throws {
    app.post("incoming") { req -> Response in
        let sms = try req.content.decode(IncomingSMS.self)

        let responseMessage = SMSResponse(
            Message(body: "Hello Friend!"),
            Message(body: "This is a second text.")
        )

        return req.twilio.respond(with: responseMessage)
    }
}
```
