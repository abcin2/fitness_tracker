import Foundation
import SwiftUI

extension ExerciseHistoryView {
    
    final class ViewModel: ObservableObject {
        
        func formatDateToString(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            return dateFormatter.string(from: date)
        }
        
        func uniqueDatesArray(for workouts: FetchedResults<Workout1>) -> [String] {
            var uniqueDates: Set<String> = []
            for workout in workouts {
                uniqueDates.insert(formatDateToString(date: workout.dateCompleted ?? Date.now))
            }
            return Array(uniqueDates)
        }

    }
    
}
