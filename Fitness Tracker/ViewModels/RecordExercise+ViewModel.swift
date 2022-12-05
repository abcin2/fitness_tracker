import Foundation
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
        @Published var bikeIntensityLevel: Int16 = 1
        @Published var inclineLevel: Double = 0.0
        @Published var machineSetting: Int16 = 1
        @Published var weight: String = "10"
        @Published var freeWeightExercise: String = ""
        @Published var reps: String = "1"
        @Published var sets: Int16 = 1
        
        let repOptions: [String] = [
            "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "to failure"
        ]
        
        func createIntArr(from: Int16, through: Int16, by: Int) -> [Int16] {
            var arr: [Int16] = []
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
        
        func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        
    }
}
