import Vapor

public struct OutgoingSMS: Content {
    let body: String
    let from: String
    let to: String

    public init(body: String, from: String, to: String) {
        self.body = body
        self.from = from
        self.to = to
    }

    private enum CodingKeys : String, CodingKey {
        case body = "Body", from = "From", to = "To"
    }
}
