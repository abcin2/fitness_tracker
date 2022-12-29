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
                    if let exercise = workouts.first(where: {$0.id == workout.id}) {
                        exercise.freeWeightExercise = viewModel.freeWeightExercise
                        exercise.weight = viewModel.weight
                        exercise.adjustment = Int16(viewModel.machineSetting)
                        exercise.incline = viewModel.inclineLevel
                        exercise.intensity = viewModel.intensityLevel
                        exercise.bikeIntensity = Int16(viewModel.bikeIntensityLevel)
                        exercise.length = viewModel.formatTimeStringBackToDouble(hours: viewModel.hoursElapsedString, minutes: viewModel.minutesElapsedString, seconds: viewModel.secondsElapsedString)
                        exercise.reps = viewModel.reps
                        exercise.sets = Int16(viewModel.sets)
                        
                        let existingPreviousWeek = previousWeeks.first(where: {$0.weekOf == viewModel.findDateRangeOfThisWeek(date: exercise.dateCompleted ?? Date.now)})
                        switch exercise.dateCompleted?.formatted(.dateTime.weekday()) {
                        case "Mon":
                            existingPreviousWeek?.minutesMon += viewModel.formatTimeStringBackToDouble(hours: viewModel.hoursElapsedString, minutes: viewModel.minutesElapsedString, seconds: viewModel.secondsElapsedString)
                        case "Tue":
                            existingPreviousWeek?.minutesTue += viewModel.formatTimeStringBackToDouble(hours: viewModel.hoursElapsedString, minutes: viewModel.minutesElapsedString, seconds: viewModel.secondsElapsedString)
                        case "Wed":
                            existingPreviousWeek?.minutesWed += viewModel.formatTimeStringBackToDouble(hours: viewModel.hoursElapsedString, minutes: viewModel.minutesElapsedString, seconds: viewModel.secondsElapsedString)
                        case "Thu":
                            existingPreviousWeek?.minutesThu += viewModel.formatTimeStringBackToDouble(hours: viewModel.hoursElapsedString, minutes: viewModel.minutesElapsedString, seconds: viewModel.secondsElapsedString)
                        case "Fri":
                            existingPreviousWeek?.minutesFri += viewModel.formatTimeStringBackToDouble(hours: viewModel.hoursElapsedString, minutes: viewModel.minutesElapsedString, seconds: viewModel.secondsElapsedString)
                        case "Sat":
                            existingPreviousWeek?.minutesSat += viewModel.formatTimeStringBackToDouble(hours: viewModel.hoursElapsedString, minutes: viewModel.minutesElapsedString, seconds: viewModel.secondsElapsedString)
                        case "Sun":
                            existingPreviousWeek?.minutesSun += viewModel.formatTimeStringBackToDouble(hours: viewModel.hoursElapsedString, minutes: viewModel.minutesElapsedString, seconds: viewModel.secondsElapsedString)
                        default:
                            return
                        }
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
