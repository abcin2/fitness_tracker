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
        
        let treadmillInclineLevels: [Double] = [
            0.0, 1.0, 1.5, 2.0, 2.5, 3.0, 3.5, 4.0, 4.5, 5.0,
            5.5, 6.0, 6.5, 7.0, 7.5, 8.0, 8.5, 9.0, 9.5, 10.0,
            10.5, 12.0, 12.5, 13.0, 13.5, 14.0, 14.5, 15.0,
            15.5, 16.0, 16.5, 17.0, 17.5, 18.0, 18.5, 19.0, 19.5, 20.0
        ]
        
        let bikeSeatHeight: [Int16] = [
            1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
            11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
            21, 22, 23, 24, 25
        ]
        
        let bikeIntensityLevels: [Int16] = [
            1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
            11, 12, 13, 14, 15, 16, 17, 18, 19, 20,
            21, 22, 23, 24, 25, 26, 27, 28, 29, 30,
            31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
            41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
        ]
        
        let intensityLevels: [Double] = [
            1.0, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9,
            2.0, 2.1, 2.2, 2.3, 2.4, 2.5, 2.6, 2.7, 2.8, 2.9,
            3.0, 3.1, 3.2, 3.3, 3.4, 3.5, 3.6, 3.7, 3.8, 3.9,
            4.0, 4.1, 4.2, 4.3, 4.4, 4.5, 4.6, 4.7, 4.8, 4.9,
            5.0, 5.1, 5.2, 5.3, 5.4, 5.5, 5.6, 5.7, 5.8, 5.9,
            6.0, 6.1, 6.2, 6.3, 6.4, 6.5, 6.6, 6.7, 6.8, 6.9,
            7.0, 7.1, 7.2, 7.3, 7.4, 7.5, 7.6, 7.7, 7.8, 7.9,
            8.0, 8.1, 8.2, 8.3, 8.4, 8.5, 8.6, 8.7, 8.8, 8.9,
            9.0, 9.1, 9.2, 9.3, 9.4, 9.5, 9.6, 9.7, 9.8, 9.9,
            10.0, 10.1, 10.2, 10.3, 10.4, 10.5, 10.6, 10.7, 10.8, 10.9,
            12.0, 12.1, 12.2, 12.3, 12.4, 12.5, 12.6, 12.7, 12.8, 12.9,
            13.0, 13.1, 13.2, 13.3, 13.4, 13.5, 13.6, 13.7, 13.8, 13.9,
            14.0, 14.1, 14.2, 14.3, 14.4, 14.5, 14.6, 14.7, 14.8, 14.9,
            15.0, 15.1, 15.2, 15.3, 15.4, 15.5, 15.6, 15.7, 15.8, 15.9,
            16.0, 16.1, 16.2, 16.3, 16.4, 16.5, 16.6, 16.7, 16.8, 16.9,
            17.0, 17.1, 17.2, 17.3, 17.4, 17.5, 17.6, 17.7, 17.8, 17.9,
            18.0, 18.1, 18.2, 18.3, 18.4, 18.5, 18.6, 18.7, 18.8, 18.9,
            19.0, 19.1, 19.2, 19.3, 19.4, 19.5, 19.6, 19.7, 19.8, 19.9, 20.0
        ]
        
        let oneThroughTen: [Int16] = [
            1, 2, 3, 4, 5, 6, 7, 8, 9, 10
        ]
        
        let oneThroughTwenty: [Int16] = [
            1, 2, 3, 4, 5, 6, 7, 8, 9, 10,
            11, 12, 13, 14, 15, 16, 17, 18, 19, 20
        ]
        
        let repOptions: [String] = [
            "1", "2", "3", "4", "5", "6", "7", "8", "9", "10",
            "11", "12", "13", "14", "15", "to failure"
        ]
        
        func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        
    }
}
