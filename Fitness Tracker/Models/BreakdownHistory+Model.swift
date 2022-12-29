import SwiftUI

struct BreakdownHistoryGraph: Identifiable {
    let id = UUID()
    let dateRange: String?
    let minutesPerDay: [minutesPerDay]?
    let graphs: [BreakdownHistoryGraph]?
}

struct minutesPerDay: Identifiable {
    let id = UUID()
    let dayOfWeek: weekday
    let time: Double
    
}

enum weekday {
    case mon, tue, wed, thu, fri, sat, sun
}
