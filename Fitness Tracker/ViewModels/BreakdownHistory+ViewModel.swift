import Foundation
import SwiftUI

extension BreakdownHistoryView {
    final class ViewModel: ObservableObject {
        
        func findDateRangeForDate(date: Date) -> String {
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
        
        func getDateRange(with data: FetchedResults<Workout>) -> [BreakdownHistoryGraph] {
            var breakdownHistoryGraphs: [BreakdownHistoryGraph] = []
            for range in getExercisesForEachRange(with: data).keys {
                breakdownHistoryGraphs.append(BreakdownHistoryGraph(dateRange: range, minutesPerDay: nil, graphs: getTotalTimes(with: data)))
            }
            return breakdownHistoryGraphs
        }
        
        func getExercisesForEachRange(with data: FetchedResults<Workout>) -> [String:[Workout]] {
            var exercises: [String:[Workout]] = [:]
            for workout in data {
                if exercises[workout.dateRange ?? "Uknown Range"] != nil {
                    exercises[workout.dateRange ?? "Uknown Range"]?.append(workout)
                } else {
                    exercises[workout.dateRange ?? "Uknown Range"] = [workout]
                }
            }
            // need to sort ranges
            return exercises
        }
        
        func getTotalTimes(with data: FetchedResults<Workout>) -> [BreakdownHistoryGraph] {
            var graphs: [BreakdownHistoryGraph] = []
            for range in getDateRanges(with: data) {
                var secondsPerDay: [String:Double] = [
                    "Mon": 0.0,
                    "Tue": 0.0,
                    "Wed": 0.0,
                    "Thu": 0.0,
                    "Fri": 0.0,
                    "Sat": 0.0,
                    "Sun": 0.0
                ]
                for workout in data {
                    if workout.dateRange == range {
                        switch workout.dateCompleted?.formatted(.dateTime.weekday()) {
                        case "Mon":
                            secondsPerDay["Mon"]! += workout.length
                        case "Tue":
                            secondsPerDay["Tue"]! += workout.length
                        case "Wed":
                            secondsPerDay["Wed"]! += workout.length
                        case "Thu":
                            secondsPerDay["Thu"]! += workout.length
                        case "Fri":
                            secondsPerDay["Fri"]! += workout.length
                        case "Sat":
                            secondsPerDay["Sat"]! += workout.length
                        case "Sun":
                            secondsPerDay["Sun"]! += workout.length
                        default:
                            secondsPerDay["Uknown"]! += workout.length
                        }
                    }
                }
                graphs.append(BreakdownHistoryGraph(dateRange: nil, minutesPerDay: [
                    minutesPerDay(dayOfWeek: .mon, time: (secondsPerDay["Mon"] ?? 0.0) / 60),
                    minutesPerDay(dayOfWeek: .tue, time: (secondsPerDay["Tue"] ?? 0.0) / 60),
                    minutesPerDay(dayOfWeek: .wed, time: (secondsPerDay["Wed"] ?? 0.0) / 60),
                    minutesPerDay(dayOfWeek: .thu, time: (secondsPerDay["Thu"] ?? 0.0) / 60),
                    minutesPerDay(dayOfWeek: .fri, time: (secondsPerDay["Fri"] ?? 0.0) / 60),
                    minutesPerDay(dayOfWeek: .sat, time: (secondsPerDay["Sat"] ?? 0.0) / 60),
                    minutesPerDay(dayOfWeek: .sun, time: (secondsPerDay["Sun"] ?? 0.0) / 60)
                ], graphs: nil))
            }
            return graphs
        }
        
        func getDateRanges(with data: FetchedResults<Workout>) -> Set<String> {
            var ranges: Set<String> = []
            for workout in data {
                ranges.insert(workout.dateRange ?? "Uknown Range")
            }
            // need to sort ranges
            return ranges
        }
        
    }
}
