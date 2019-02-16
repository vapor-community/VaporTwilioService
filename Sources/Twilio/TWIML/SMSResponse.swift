public protocol TwimlGenerator {
    func generateTwiml() -> String
}

public protocol Verb: TwimlGenerator {  }

public struct Message: Verb {
    let body: String
    let maxMessageLength: Int

    public init(body: String, maxMessageLength: Int = 1600) {
        self.body = body
        self.maxMessageLength = maxMessageLength
    }

    public func generateTwiml() -> String {
        let processedBody = body.xmlEscaped
        
        // There's a character limit on twilio messages
        let preprocessed: String = processedBody.enumerated().map { (offset, element) in
            let altered: String = ((offset + 1) % self.maxMessageLength == 0) ? "🔤" + String(element) : String(element)
            return altered
        }.joined()
        let strings = preprocessed.split(separator: "🔤")
        let messages = strings
            .map { generateSingleMessage(body: $0)}
            .joined(separator: "\n")
        
        return messages
    }
    
    fileprivate func generateSingleMessage<T: StringProtocol>(body: T) -> String {
        let single = """
        <Message>
            <Body>
                \(body)
            </Body>
        </Message>
        """
        
        return single
    }
}

public struct SMSResponse: TwimlGenerator {
    let verbs: [Verb]

    public init(_ verbs: Verb...) {
        self.verbs = verbs
    }
    
    public init(_ verbs: [Verb]) {
        self.verbs = verbs
    }

    public func generateTwiml() -> String {
        return """
        <?xml version="1.0" encoding="UTF-8" ?>
        <Response>
            \(verbs.map { $0.generateTwiml() }.joined(separator: "\n"))
        </Response>
        """
    }
}
