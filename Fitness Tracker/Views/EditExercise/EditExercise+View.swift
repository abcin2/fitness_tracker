import Combine
import SwiftUI

struct EditExerciseView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Workout.entity(), sortDescriptors: [])
    var workouts: FetchedResults<Workout>
    @FetchRequest(entity: PreviousWeek.entity(), sortDescriptors: [])
    var previousWeeks: FetchedResults<PreviousWeek>
    @ObservedObject var workout: Workout
    @ObservedObject var viewModel = ViewModel()
    var body: some View {
        VStack {
            switch workout.category {
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
            editButtons
                .frame(height: 125)
        }
        .navigationTitle(workout.name ?? "Unknown")
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
