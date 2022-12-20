import SwiftUI

struct ExerciseHistoryView: View {
    @FetchRequest(sortDescriptors: [SortDescriptor(\.dateCompleted)])
    var workouts: FetchedResults<Workout>
    @FetchRequest(entity: PreviousWeek.entity(), sortDescriptors: [])
    var previousWeeks: FetchedResults<PreviousWeek>
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var viewModel = ViewModel()
    
    func findDateRangeOfThisWeek(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.setLocalizedDateFormatFromTemplate("MMM d")
        
        var dateRange: String = ""
        
        let currentWeekday = date.formatted(.dateTime.weekday())
        if currentWeekday == "Mon" {
            dateRange += dateFormatter.string(from: date)
            dateRange += " - "
            let endOfWeek = Calendar.current.date(byAdding: .day, value: 6, to: date)!
            dateRange += dateFormatter.string(from: endOfWeek)
        } else {
            for num in 1...6 {
                let selectedWeekday = Calendar.current.date(byAdding: .day, value: -(num), to: date)!.formatted(.dateTime.weekday())
                if selectedWeekday == "Mon" {
                    let firstMondayOfWeek = Calendar.current.date(byAdding: .day, value: -(num), to: date)!
                    dateRange += dateFormatter.string(from: firstMondayOfWeek)
                    dateRange += " - "
                    let endOfWeek = Calendar.current.date(byAdding: .day, value: 6, to: firstMondayOfWeek)!
                    dateRange += dateFormatter.string(from: endOfWeek)
                }
            }
        }
        return dateRange
    }
    
    func deleteWorkout(at offsets: IndexSet) {
        for offset in offsets {
            let workout = workouts[offset]
            moc.delete(workout)
            // subtract time in workout from total in previousWeeks
            let deletedWorkoutTime = workout.length
            let existingPreviousWeek = previousWeeks.first(where: {$0.weekOf == findDateRangeOfThisWeek(date: workout.dateCompleted ?? Date.now)})
            switch workout.dateCompleted?.formatted(.dateTime.weekday()) {
            case "Mon":
                existingPreviousWeek?.minutesMon -= deletedWorkoutTime
            case "Tue":
                existingPreviousWeek?.minutesTue -= deletedWorkoutTime
            case "Wed":
                existingPreviousWeek?.minutesWed -= deletedWorkoutTime
            case "Thu":
                existingPreviousWeek?.minutesThu -= deletedWorkoutTime
            case "Fri":
                existingPreviousWeek?.minutesFri -= deletedWorkoutTime
            case "Sat":
                existingPreviousWeek?.minutesSat -= deletedWorkoutTime
            case "Sun":
                existingPreviousWeek?.minutesSun -= deletedWorkoutTime
            default:
                return
            }
            // will need to remove time from PreviousWeek in this logic
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
