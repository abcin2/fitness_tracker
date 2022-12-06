import Combine
import SwiftUI

struct EditExerciseView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Workout.entity(), sortDescriptors: [])
    var workouts: FetchedResults<Workout>
    @ObservedObject var workout: Workout
    @ObservedObject var viewModel = ViewModel()
    var body: some View {
        VStack {
            timer
            switch workout.category {
            case "Cardio Machines":
                VStack {
                    Text("Details:")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    cardioMachines
                }
                .padding(.vertical)
            case "Arm, Shoulder & Chest Machines":
                VStack {
                    Text("Details:")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    ASCMachines
                }
                .padding(.vertical)
            case "Leg Machines":
                VStack {
                    Text("Details:")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    legMachines
                }
                .padding(.vertical)
            case "Core Machines":
                VStack {
                    Text("Details:")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    coreMachines
                }
                .padding(.vertical)
            case "Other":
                VStack {
                    Text("Details:")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    other
                }
                .padding(.vertical)
            default:
                unknown
            }
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
                        .background(.white)
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
            // need function to convert this string BACK to an int
        }
        .navigationTitle(workout.name ?? "Unknown")
        .padding(.vertical)
        .onAppear {
            viewModel.initializeDataFromCoreDataWorkout(with: workout)
        }
        .onTapGesture {
            viewModel.hideKeyboard()
        }
    }
}

private extension EditExerciseView {
    var unknown: some View {
        VStack {
            Text("Cannot find associated category. Please try again")
        }
    }
}

//struct EditExerciseView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditExerciseView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
//    }
//}
