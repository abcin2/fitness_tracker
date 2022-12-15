import Foundation
import SwiftUI

extension BreakdownHistoryView {
    final class ViewModel: ObservableObject {
        var weeksOf: [String] = ["Week of _ to _", "Week of _ to __"]
        
        // might make more sense to create a separate DB with previous weeks data...
        func getWeeksOf(workouts: FetchedResults<Workout>) -> [String] {
            var weeksOf: [String] = []
            var currWeek: String = ""
            
            return weeksOf
        }
    }
}
