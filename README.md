
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
<a href="https://swift.org">
    <img src="http://img.shields.io/badge/swift-4.1-brightgreen.svg" alt="Swift 4.1">
</a>

# What

This is a wrapper service for interacting with the Twilio API

## Installation

```swift
 .package(url: "https://github.com/twof/VaporTwilioService.git", from: "1.0.0")
```

## Usage

### Setup
```swift
// Setup
guard let accountId = Environment.get("TWILIO_ACCOUNT_ID") else { fatalError() }
guard let accountSecret = Environment.get("TWILIO_ACCOUNT_SECRET") else { fatalError() }
let twilio = Twilio(accountId: accountId, accountSecret: accountSecret)

services.register(twilio)
```
### Sending a text
```swift
let twilio = try req.make(Twilio.self)

let sms = OutgoingSMS(body: "Hey There", from: "+15556100806", to: "+15553688346")

return try twilio.send(sms, on: req)
```
