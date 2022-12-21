import Foundation
import SwiftUI

extension BreakdownHistoryView {
    final class ViewModel: ObservableObject {
        
        func findClosestMondayBeforeToday() -> Date {
            let currentWeekday = Date.now.formatted(.dateTime.weekday())
            // only needs to go 1...6
            if currentWeekday == "Mon" {
                return Date.now
            } else {
                for num in 1...6 {
                    let selectedWeekday = Calendar.current.date(byAdding: .day, value: -(num), to: Date.now)!.formatted(.dateTime.weekday())
                    if selectedWeekday == "Mon" {
                        return Calendar.current.date(byAdding: .day, value: -(num), to: Date.now)!
                    }
                }
            }
            return Date.now
        }
        
        func minutesPerDayThisWeek(workouts: FetchedResults<Workout>) -> [String:Double] {
            var minutesPerDayDict: [String:Double] = [
                "Mon": 0.0,
                "Tue": 0.0,
                "Wed": 0.0,
                "Thu": 0.0,
                "Fri": 0.0,
                "Sat": 0.0,
                "Sun": 0.0,
            ]
            
            let firstMondayInWeek: Date = findClosestMondayBeforeToday()
            for nextDay in 0...6 {
                var minutesExercised: Double = 0.0
                let currentDay = Calendar.current.date(byAdding: .day, value: nextDay, to: firstMondayInWeek)!.formatted(.dateTime.day().month())
                for workout in workouts {
                    let recordedDay = (workout.dateCompleted ?? Date.now).formatted(.dateTime.day().month())
                    if currentDay == recordedDay {
                        minutesExercised += workout.length
                    }
                }
                minutesPerDayDict[Calendar.current.date(byAdding: .day, value: nextDay, to: firstMondayInWeek)!.formatted(.dateTime.weekday())] = minutesExercised / 60
            }
            return minutesPerDayDict
        }
        
    }
}
