import Combine
import Foundation
import SwiftUI

extension EditExerciseView {
    final class ViewModel: ObservableObject {
        
        // MARK: May be better to make minutes and seconds as pickers that range from 0...59
        @Published var timeElapsed: Double = 0.0
        @Published var minutesElapsedString: String = ""
        @Published var secondsElapsedString: String = ""
        @Published var intensityLevel: Double = 1.0
        @Published var bikeIntensityLevel: Int16 = 1
        @Published var inclineLevel: Double = 0.0
        @Published var machineSetting: Int16 = 1
        @Published var weight: String = "10"
        @Published var freeWeightExercise: String = ""
        @Published var reps: String = "1"
        @Published var sets: Int16 = 1
        
        var timeElapsedFormatted: String = ""
        
        func initializeDataFromCoreDataWorkout(with data: Workout) -> Void {
            timeElapsed = data.length
            timeElapsedFormatted = formatMmSs(counter: data.length)
            minutesElapsedString = timeElapsedFormatted.components(separatedBy: ":")[0]
            secondsElapsedString = timeElapsedFormatted.components(separatedBy: ":")[1]
            intensityLevel = data.intensity
            inclineLevel = data.incline
            machineSetting = data.adjustment
            freeWeightExercise = data.freeWeightExercise ?? ""
            weight = data.weight ?? ""
            reps = data.reps ?? "1"
            sets = data.sets
        }
        
        func formatMmSs(counter: Double) -> String {
            let minutes = Int(counter) / 60 % 60
            let seconds = Int(counter) % 60
            let milliseconds = (Int(counter*1000) % 1000) / 10
            return String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
        }
        
        func formatTimeStringBackToDouble(minutes: String, seconds: String) -> Double {
            return (Double(minutes)! * 60 + Double(seconds)!)
        }
        
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
        
        func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        
    }
}
