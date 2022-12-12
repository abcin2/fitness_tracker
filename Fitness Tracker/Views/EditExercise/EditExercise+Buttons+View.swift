import Combine
import SwiftUI

extension EditExerciseView {
    var editButtons: some View {
        VStack {
            Spacer()
            HStack {
                Button(action: {
                    moc.delete(workout)
                    try? moc.save()
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Delete")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.white.opacity(0))
                        .foregroundColor(.blue)
                        .font(.subheadline)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            HStack {
                Button(action: {
                    if let exercise = workouts.first(where: {$0.name == workout.name}) {
                        exercise.freeWeightExercise = viewModel.freeWeightExercise
                        exercise.weight = viewModel.weight
                        exercise.adjustment = Int16(viewModel.machineSetting)
                        exercise.incline = viewModel.inclineLevel
                        exercise.intensity = viewModel.intensityLevel
                        exercise.bikeIntensity = Int16(viewModel.bikeIntensityLevel)
                        exercise.length = viewModel.formatTimeStringBackToDouble(minutes: viewModel.minutesElapsedString, seconds: viewModel.secondsElapsedString)
                        exercise.dateCompleted = Date.now
                        exercise.reps = viewModel.reps
                        exercise.sets = Int16(viewModel.sets)
                        try? moc.save()
                        presentationMode.wrappedValue.dismiss()
                    }
                }) {
                    Text("Save Changes")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
        }
        .padding(.bottom)
    }
}
