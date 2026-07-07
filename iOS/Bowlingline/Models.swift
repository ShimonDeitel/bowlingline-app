import Foundation

struct OutingEntry: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var title: String
    var vendor: String
    var amount: Double
    var date: Date
    var notes: String = ""

    static func == (lhs: OutingEntry, rhs: OutingEntry) -> Bool {
        lhs.id == rhs.id
    }
}
