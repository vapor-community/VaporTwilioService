import Twilio
import XCTest

final class TWIMLTests: XCTestCase {
    func testSMSResponse() throws {
        let smsResponse = SMSResponse()
        
        let expectedTwiml =
"""
<?xml version="1.0" encoding="UTF-8" ?>
<Response>

</Response>
"""
        
        XCTAssertEqual(smsResponse.generateTwiml(), expectedTwiml)
    }
    
    func testMessage() throws {
        let message = Message(body: "Hello!")
        let expectedTwiml =
"""
    <Message>
        <Body>
            Hello!
        </Body>
    </Message>
"""
        
        XCTAssertEqual(message.generateTwiml(), expectedTwiml)
    }
    
    func testSMSResponseWithSingleMessage() throws {
        let message = Message(body: "Hello!")
        let smsResponseWithMessage = SMSResponse(message)
        
        let expectedTwiml = """
        <?xml version="1.0" encoding="UTF-8" ?>
        <Response>
            <Message>
                <Body>
                    Hello!
                </Body>
            </Message>
        </Response>
        """
        
        XCTAssertEqual(smsResponseWithMessage.generateTwiml(), expectedTwiml)
    }
    
    func testSMSResponseWithMultipleMessages() throws {
        let message = Message(body: "Hello")
        let otherMessage = Message(body: "world!")
        let smsResponseWithMessage = SMSResponse(message, otherMessage)
        
        let expectedTwiml = """
        <?xml version="1.0" encoding="UTF-8" ?>
        <Response>
            <Message>
                <Body>
                    Hello
                </Body>
            </Message>
            <Message>
                <Body>
                    world!
                </Body>
            </Message>
        </Response>
        """
        
        XCTAssertEqual(smsResponseWithMessage.generateTwiml(), expectedTwiml)
    }
    
    func testSMSResponseForEscapedBody() throws {
        let message = Message(body: "enemy<goblin>")
        let smsResponseWithMessage = SMSResponse(message)
        
        let expectedTwiml = """
        <?xml version="1.0" encoding="UTF-8" ?>
        <Response>
            <Message>
                <Body>
                    enemy&lt;goblin&gt;
                </Body>
            </Message>
        </Response>
        """
        
        XCTAssertEqual(smsResponseWithMessage.generateTwiml(), expectedTwiml)
    }
}
