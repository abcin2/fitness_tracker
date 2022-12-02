import SwiftUI
import Combine

extension RecordExerciseView {
    var timer: some View {
        VStack {
            Spacer()
            Text(String(format: viewModel.formatMmSs(counter: viewModel.secondsElapsed), viewModel.secondsElapsed))
                .font(.largeTitle)
            switch viewModel.mode {
            case .stopped:
                Button(action: {
                    viewModel.startTimer()
                }) {
                    Text("Start Exercise!")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .cornerRadius(10)
                }
            case .paused:
                Button(action: {
                    viewModel.resetTimer()
                    print("Test")
                }) {
                    Text("Reset")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.white.opacity(0))
                        .foregroundColor(.blue)
                        .font(.subheadline)
                        .cornerRadius(10)
                }
                .alert("Are you sure you would like to reset the timer?", isPresented: $viewModel.showResetTimerModal) {
                    Button("NO", role: .destructive) {
                        viewModel.cancelResetTimer()
                    }
                    Button("YES", role: .cancel) {
                        viewModel.confirmResetTimer()
                    }
                }
                Button(action: {
                    viewModel.stopTimer()
                }) {
                    Text("Stop & Record")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.red)
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .cornerRadius(10)
                }
                .alert("Are you sure you want to stop and save this workout?", isPresented: $viewModel.showConfirmSaveWorkoutModal) {
                    Button("NO", role: .destructive) {
                        viewModel.cancelSaveWorkout()
                    }
                    Button("YES", role: .cancel) {
                        let workout = Workout(context: moc)
                        workout.id = UUID()
                        workout.category = viewModel.findCategory(for: exercise)
                        workout.name = exercise
                        workout.freeWeightExercise = viewModel.freeWeightExercise
                        workout.weight = viewModel.weight
                        workout.adjustment = viewModel.machineSetting
                        workout.incline = viewModel.inclineLevel
                        workout.intensity = viewModel.intensityLevel
                        workout.length = viewModel.secondsElapsed
                        workout.dateCompleted = Date.now
                        workout.reps = viewModel.reps
                        workout.sets = viewModel.sets
                        try? moc.save()
                        viewModel.confirmSaveWorkout()
                        presentationMode.wrappedValue.dismiss()
                    }
                }
                Button(action: {
                    viewModel.startTimer()
                }) {
                    Text("Continue")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.blue)
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .cornerRadius(10)
                }
            case .running:
                Button(action: {
                    viewModel.pauseTimer()
                }) {
                    Text("Pause")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(.yellow)
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .cornerRadius(10)
                }
            }
        }
    }
}
