import Foundation
import SwiftUI

extension ExerciseHistoryView {
    
    final class ViewModel: ObservableObject {
        
        func formatDateToString(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM dd, yyyy"
            return dateFormatter.string(from: date)
        }
        
        func uniqueDatesArray(for workouts: FetchedResults<Workout>) -> [String] {
            var uniqueDates: Set<String> = []
            for workout in workouts {
                uniqueDates.insert(formatDateToString(date: workout.dateCompleted ?? Date.now))
            }
            return Array(uniqueDates)
        }
        
        func findDateRangeOfThisWeek(date: Date) -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.setLocalizedDateFormatFromTemplate("MMM d")
            
            var dateRange: String = ""
            
            let currentWeekday = date.formatted(.dateTime.weekday())
            if currentWeekday == "Mon" {
                dateRange += dateFormatter.string(from: date)
                dateRange += " - "
                let endOfWeek = Calendar.current.date(byAdding: .day, value: 6, to: date)!
                dateRange += dateFormatter.string(from: endOfWeek)
            } else {
                for num in 1...6 {
                    let selectedWeekday = Calendar.current.date(byAdding: .day, value: -(num), to: date)!.formatted(.dateTime.weekday())
                    if selectedWeekday == "Mon" {
                        let firstMondayOfWeek = Calendar.current.date(byAdding: .day, value: -(num), to: date)!
                        dateRange += dateFormatter.string(from: firstMondayOfWeek)
                        dateRange += " - "
                        let endOfWeek = Calendar.current.date(byAdding: .day, value: 6, to: firstMondayOfWeek)!
                        dateRange += dateFormatter.string(from: endOfWeek)
                    }
                }
            }
            return dateRange
        }

    }
    
}
