import Foundation

extension String {
    var xmlEscaped: String {
        return replacingOccurrences(of: "&", with: "&amp;")
            .replacingOccurrences(of: "\"", with: "&quot;")
            .replacingOccurrences(of: "'", with: "&#39;")
            .replacingOccurrences(of: ">", with: "&gt;")
            .replacingOccurrences(of: "<", with: "&lt;")
    }
}
