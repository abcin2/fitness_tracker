import SwiftUI
import Combine

struct RecordExerciseView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Workout.entity(), sortDescriptors: [])
    var workouts: FetchedResults<Workout>
    @ObservedObject var viewModel = ViewModel()
    @State var workout: String
    var body: some View {
        VStack {
            switch viewModel.findCategory(for: workout) {
            case "Cardio Machines":
                cardioMachines
            case "Arm, Shoulder & Chest Machines":
                ASCMachines
            case "Leg Machines":
                legMachines
            case "Core Machines":
                coreMachines
            case "Other":
                other
            default:
                unknown
            }
            Spacer()
            timer
                .padding()
                .frame(height: 250)
            Spacer()
        }
        .navigationTitle(workout)
        .onAppear {
            viewModel.initializeDataFromPreviousRecordedWorkout(with: workouts, workout: workout)
        }
        .onTapGesture {
            viewModel.hideKeyboard()
        }
    }
}

private extension RecordExerciseView {
    var unknown: some View {
        VStack {
            Text("Cannot find associated category. Please try again")
        }
    }
}

struct RecordExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        RecordExerciseView(workout: "Treadmill")
    }
}
