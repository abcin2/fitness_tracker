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
                        // save workout
                        let exercise = Workout(context: moc)
                        exercise.id = UUID()
                        exercise.category = viewModel.findCategory(for: workout)
                        exercise.name = workout
                        exercise.freeWeightExercise = viewModel.freeWeightExercise
                        exercise.weight = viewModel.weight
                        exercise.adjustment = Int16(viewModel.machineSetting)
                        exercise.incline = viewModel.inclineLevel
                        exercise.intensity = viewModel.intensityLevel
                        exercise.bikeIntensity = Int16(viewModel.bikeIntensityLevel)
                        exercise.length = viewModel.secondsElapsed
                        exercise.dateCompleted = Date.now
                        exercise.reps = viewModel.reps
                        exercise.sets = Int16(viewModel.sets)
                        try? moc.save()
                        // save workout to previous week entity if it is the first workout of the week
                        // if statement needed when more workouts are added to week
                        let previousWeek = PreviousWeek(context: moc)
                        previousWeek.id = UUID()
                        previousWeek.weekOf = viewModel.findDateRangeOfThisWeek()
                        // switch to determine day
                        switch Date.now.formatted(.dateTime.weekday()) {
                        case "Mon":
                            previousWeek.minutesMon += viewModel.secondsElapsed
                        case "Tue":
                            previousWeek.minutesTue += viewModel.secondsElapsed
                        case "Wed":
                            previousWeek.minutesWed += viewModel.secondsElapsed
                        case "Thu":
                            previousWeek.minutesThu += viewModel.secondsElapsed
                        case "Fri":
                            previousWeek.minutesFri += viewModel.secondsElapsed
                        case "Sat":
                            previousWeek.minutesSat += viewModel.secondsElapsed
                        case "Sun":
                            previousWeek.minutesSun += viewModel.secondsElapsed
                        default:
                            return
                        }
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
