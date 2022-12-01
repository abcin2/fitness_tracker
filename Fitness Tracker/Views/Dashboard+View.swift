import SwiftUI
import Charts

struct DashboardView: View {
    
    @FetchRequest(sortDescriptors: []) var workouts: FetchedResults<Workout>
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Frequently Recorded:")) {
                    ForEach(viewModel.topThreeWorkouts(workouts: workouts), id: \.self) { workout in
                        NavigationLink(destination: RecordExerciseView(exercise: workout)) {
                            Text(workout)
                        }
                    }
                }
                Section(header: Text("Exercise Breakdown:")) {
                    Chart {
                        BarMark (
                            x: .value("Day", "Mon"),
                            y: .value("Total Minutes", viewModel.minutesPerDayThisWeek(workouts: workouts)["Mon"] ?? 0.0)
                        )
                        BarMark (
                            x: .value("Day", "Tue"),
                            y: .value("Total Minutes", viewModel.minutesPerDayThisWeek(workouts: workouts)["Tue"] ?? 0.0)
                        )
                        BarMark (
                            x: .value("Day", "Wed"),
                            y: .value("Total Minutes", viewModel.minutesPerDayThisWeek(workouts: workouts)["Wed"] ?? 0.0)
                        )
                        BarMark (
                            x: .value("Day", "Thu"),
                            y: .value("Total Minutes", viewModel.minutesPerDayThisWeek(workouts: workouts)["Thu"] ?? 0.0)
                        )
                        BarMark (
                            x: .value("Day", "Fri"),
                            y: .value("Total Minutes", viewModel.minutesPerDayThisWeek(workouts: workouts)["Fri"] ?? 0.0)
                        )
                        BarMark (
                            x: .value("Day", "Sat"),
                            y: .value("Total Minutes", viewModel.minutesPerDayThisWeek(workouts: workouts)["Sat"] ?? 0.0)
                        )
                        BarMark (
                            x: .value("Day", "Sun"),
                            y: .value("Total Minutes", viewModel.minutesPerDayThisWeek(workouts: workouts)["Sun"] ?? 0.0)
                        )
                    }
                    .frame(height: 250)
                }
            }
            .padding(.bottom)
            HStack {
                NavigationLink(destination: ExerciseHistoryView()) {
                    Text("Exercise History")
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
                NavigationLink(destination: ExercisesListView()) {
                    Text("Find Exercise")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.blue)
                        .foregroundColor(.white)
                        .font(.subheadline)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
            Spacer()
        }
        .padding(.vertical, 8)
        .navigationTitle("Dashboard")
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
