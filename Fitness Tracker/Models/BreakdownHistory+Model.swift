import SwiftUI

struct BreakdownHistoryGraph: Identifiable {
    let id = UUID()
    let dateRange: String?
    let minutesPerDay: Double?
    let graphs: [BreakdownHistoryGraph]?
}
