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
            ScrollView {
                timer
                switch workout.category {
                case "Cardio Machines":
                    ExerciseCategoryHeader {
                        cardioMachines
                    }
                case "Arm, Shoulder & Chest Machines":
                    ExerciseCategoryHeader {
                        ASCMachines
                    }
                case "Leg Machines":
                    ExerciseCategoryHeader {
                        legMachines
                    }
                case "Core Machines":
                    ExerciseCategoryHeader {
                        coreMachines
                    }
                case "Other":
                    ExerciseCategoryHeader {
                        other
                    }
                default:
                    unknown
                }
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
