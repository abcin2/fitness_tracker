import Combine
import SwiftUI

extension EditExerciseView {
    var timer: some View {
        // all workouts will have an option to edit the amount of time
        Section(header: Text("Exercise Time:")) {
            HStack {
                Section(header: Text("Hours").frame(maxWidth: .infinity, alignment: .leading)) {
                    TextField("", text: $viewModel.hoursElapsedString)
                        .multilineTextAlignment(.trailing)
                }
            }
            HStack {
                Section(header: Text("Minutes").frame(maxWidth: .infinity, alignment: .leading)) {
                    TextField("", text: $viewModel.minutesElapsedString)
                        .multilineTextAlignment(.trailing)
                }
            }
            HStack {
                Section(header: Text("Seconds").frame(maxWidth: .infinity, alignment: .leading)) {
                    TextField("", text: $viewModel.secondsElapsedString)
                        .multilineTextAlignment(.trailing)
                }
            }
        }
    }
}
