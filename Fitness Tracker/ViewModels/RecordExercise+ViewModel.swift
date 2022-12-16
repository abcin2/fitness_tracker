import Combine
import Foundation
import SwiftUI
import UIKit
import WidgetKit

extension RecordExerciseView {
    final class ViewModel: ObservableObject {

        // MARK: timer stuff
        @Published var mode: stopWatchMode = .stopped
        @Published var secondsElapsed: Double = 0.0
        var timer = Timer()
        var totalAccumulatedTime = 0.0
        
        var showConfirmSaveWorkoutModal: Bool = false
        var showResetTimerModal: Bool = false
        
        var fieldsDisabled: Bool = false
        
        func formatMmSs(counter: Double) -> String {
            let minutes = Int(counter) / 60 % 60
            let seconds = Int(counter) % 60
            let milliseconds = (Int(counter*1000) % 1000) / 10
            return String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
        }
        
        func startTimer() {
            var lastTimeObserved = Date.now
            mode = .running
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
                self.fieldsDisabled = true
                self.secondsElapsed += 0.01
                let currentTime = Date.now
                let currentAccumulatedTime = currentTime.timeIntervalSince(lastTimeObserved)
                self.totalAccumulatedTime += currentAccumulatedTime
                lastTimeObserved = currentTime
                self.secondsElapsed = self.totalAccumulatedTime
                WidgetCenter.shared.reloadAllTimelines()
            }
        }
        
        func stopTimer() {
            timer.invalidate()
            secondsElapsed = secondsElapsed
            fieldsDisabled = false
            showConfirmSaveWorkoutModal = true
        }
        
        func confirmSaveWorkout() {
            fieldsDisabled = false
            secondsElapsed = 0
            intensityLevel = 1.0
            bikeIntensityLevel = 1
            inclineLevel = 0.0
            machineSetting = 1
            weight = "10"
            freeWeightExercise = ""
            reps = repOptions[0]
            sets = 1
            self.totalAccumulatedTime = 0.0
            mode = .stopped
        }
        
        func cancelSaveWorkout() {
            fieldsDisabled = false
            showConfirmSaveWorkoutModal = false
        }
        
        func pauseTimer() {
            fieldsDisabled = false
            timer.invalidate()
            mode = .paused
        }
        
        func resetTimer() {
            fieldsDisabled = false
            timer.invalidate()
            secondsElapsed = secondsElapsed
            showResetTimerModal = true
        }
        
        func confirmResetTimer() {
            fieldsDisabled = false
            timer.invalidate()
            self.totalAccumulatedTime = 0.0
            secondsElapsed = 0
            mode = .stopped
        }
        
        func cancelResetTimer() {
            fieldsDisabled = false
            showResetTimerModal = false
        }
        
        enum stopWatchMode {
            case running, paused, stopped
        }
        
        // MARK: finding exercise category
        let data = ExercisesListView().viewModel.data
        
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
        
        func initializeDataFromPreviousRecordedWorkout(with data: FetchedResults<Workout>, workout: String) -> Void {
            var foundExercise: Workout? = nil
            // var dataFound: Bool = false
            for exercise in data {
                if exercise.name == workout {
                    // dataFound = true
                    foundExercise = exercise
                    break // only populates with the most recent data
                }
            }
            if foundExercise != nil {
                /// existing data here from foundExercise equal to all Published vars in viewModel
                intensityLevel = foundExercise!.intensity
                bikeIntensityLevel = Int(foundExercise!.bikeIntensity)
                inclineLevel = foundExercise!.incline
                machineSetting = Int(foundExercise!.adjustment)
                weight = foundExercise!.weight!
                freeWeightExercise = foundExercise!.freeWeightExercise!
                reps = foundExercise!.reps!
                sets = Int(foundExercise!.sets)
            }
            /// may not need else statement since values are already populated with defaults from viewModel
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

        func findCategory(for exercise: String) -> String {
            for cat in data {
                for exc in cat.exercisesOptions {
                    if exc == exercise {
                        return cat.exerciseCategory
                    }
                }
            }
            return "None Available"
        }
        
        func findDateRangeOfThisWeek() -> String {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.setLocalizedDateFormatFromTemplate("MMM d")
            
            var dateRange: String = ""
            
            let currentWeekday = Date.now.formatted(.dateTime.weekday())
            if currentWeekday == "Mon" {
                dateRange += dateFormatter.string(from: Date.now)
                dateRange += " to "
                let endOfWeek = Calendar.current.date(byAdding: .day, value: 6, to: Date.now)!
                dateRange += dateFormatter.string(from: endOfWeek)
            } else {
                for num in 1...6 {
                    let selectedWeekday = Calendar.current.date(byAdding: .day, value: -(num), to: Date.now)!.formatted(.dateTime.weekday())
                    if selectedWeekday == "Mon" {
                        let firstMondayOfWeek = Calendar.current.date(byAdding: .day, value: -(num), to: Date.now)!
                        dateRange += dateFormatter.string(from: firstMondayOfWeek)
                        dateRange += " to "
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
