import Combine
import Foundation
import SwiftUI

extension EditExerciseView {
    final class ViewModel: ObservableObject {
        
        // MARK: May be better to make minutes and seconds as pickers that range from 0...59
        @Published var timeElapsed: Double = 0.0
        @Published var hoursElapsedString: String = ""
        @Published var minutesElapsedString: String = ""
        @Published var secondsElapsedString: String = ""
        @Published var intensityLevel: Double = 1.0
        @Published var bikeIntensityLevel: Int = 1
        @Published var inclineLevel: Double = 0.0
        @Published var machineSetting: Int = 1
        @Published var weight: String = "10"
        @Published var freeWeightExercise: String = ""
        @Published var reps: String = "1"
        @Published var sets: Int = 1
        
        // Bools to control picker visability
        @Published var intensityPickerDisabled: Bool = true
        @Published var settingOnePickerDisabled: Bool = true
        @Published var settingTwoPickerDisabled: Bool = true
        @Published var settingThreePickerDisabled: Bool = true
        @Published var setsPickerDisabled: Bool = true
        @Published var repsPickerDisabled: Bool = true
        
        var timeElapsedFormatted: String = ""
        
        func initializeDataFromCoreDataWorkout(with data: Workout) -> Void {
            timeElapsed = data.length
            timeElapsedFormatted = formatMmSs(counter: data.length)
            hoursElapsedString = timeElapsedFormatted.components(separatedBy: ":")[0]
            minutesElapsedString = timeElapsedFormatted.components(separatedBy: ":")[1]
            secondsElapsedString = timeElapsedFormatted.components(separatedBy: ":")[2]
            intensityLevel = data.intensity
            bikeIntensityLevel = Int(data.bikeIntensity)
            inclineLevel = data.incline
            machineSetting = Int(data.adjustment)
            freeWeightExercise = data.freeWeightExercise ?? ""
            weight = data.weight ?? ""
            reps = data.reps ?? "1"
            sets = Int(data.sets)
        }
        
        func formatMmSs(counter: Double) -> String {
            let hours = Int(counter) / 3600
            let minutes = Int(counter) / 60 % 60
            let seconds = Int(counter) % 60
            let milliseconds = (Int(counter*1000) % 1000) / 10
            return String(format: "%02d:%02d:%02d:%02d", hours, minutes, seconds, milliseconds)
        }
        
        func formatTimeStringBackToDouble(hours: String, minutes: String, seconds: String) -> Double {
            let hours = Double(hours)! * 3600
            let minutes = Double(minutes)! * 60
            let seconds = Double(seconds)!
            return (hours + minutes + seconds)
        }
        
        let repOptions: [String] = [
            "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "to failure"
        ]
        
        func createIntArr(from: Int, through: Int, by: Int) -> [Int] {
            var arr: [Int] = []
            for i in stride(from: from, through: through, by: by) {
                arr.append(i)
            }
            return arr
        }
        
        func createDoubleArr(from: Double, through: Double, by: Double) -> [Double] {
            var arr: [Double] = []
            for i in stride(from: from, through: through, by: by) {
                arr.append(i)
            }
            return arr
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

        
        func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        
    }
}
