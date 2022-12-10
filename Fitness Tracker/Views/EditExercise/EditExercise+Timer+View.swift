import Combine
import SwiftUI

extension EditExerciseView {
    var timer: some View {
        VStack {
            Text("Exercise Time:")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading)
            // all workouts will have an option to edit the amount of time
            HStack {
                Section(header: Text("Minutes").frame(maxWidth: .infinity, alignment: .leading)) {
                    TextField("", text: $viewModel.minutesElapsedString)
                        .frame(width: 35)
                }
                .padding(.horizontal)
                .frame(height: 50)
            }
            .overlay(Divider(), alignment: .top)
            .overlay(Divider(), alignment: .bottom)
            HStack {
                Section(header: Text("Seconds").frame(maxWidth: .infinity, alignment: .leading)) {
                    TextField("", text: $viewModel.secondsElapsedString)
                        .frame(width: 35)
                }
                .padding(.horizontal)
                .frame(height: 50)
            }
            .overlay(Divider(), alignment: .top)
            .overlay(Divider(), alignment: .bottom)
        }
        .padding(.vertical)
    }
}
