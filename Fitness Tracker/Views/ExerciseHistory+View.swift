import SwiftUI

struct ExerciseHistoryView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.dateCompleted)]) var workouts: FetchedResults<Workout>
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var viewModel = ViewModel()
    
    func deleteWorkout(at offsets: IndexSet) {
        for offset in offsets {
            let workout = workouts[offset]
            moc.delete(workout)
        }
        try? moc.save()
    }
    
    var body: some View {
        // this will eventually change to drop down menus for each day
        VStack {
            List {
                ForEach(viewModel.uniqueDatesArray(for: workouts), id: \.self) { date in
                    Section(header: Text(date)) {
                        ForEach(workouts, id: \.self) { workout in
                            if viewModel.formatDateToString(date: workout.dateCompleted ?? Date.now) == date {
                                NavigationLink(destination: EditExerciseView(workout: workout)) {
                                    HStack {
                                        Text(workout.name ?? "Unknown")
                                    }
                                }
                            }
                        }
                        .onDelete(perform: deleteWorkout)
                    }
                }
            }
        }
        .navigationTitle("Exercise History")
    }
}

struct ExerciseHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        ExerciseHistoryView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
