public protocol TwimlGenerator {
    func generateTwiml() -> String
}

public protocol Verb: TwimlGenerator {  }

public struct Message: Verb {
    let body: String

    public init(body: String) {
        self.body = body
    }

    public func generateTwiml() -> String {
        return """
        <Message>
            <Body>
                \(body.xmlEscaped)
            </Body>
        </Message>
        """
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
