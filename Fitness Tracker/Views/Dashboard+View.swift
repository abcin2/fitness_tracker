import SwiftUI
import Charts

struct DashboardView: View {
    
    @FetchRequest(sortDescriptors: []) var workouts: FetchedResults<Workout>
    @Environment(\.managedObjectContext) var moc
    @ObservedObject var viewModel = ViewModel()
    
    func reRecordWorkoutWithNoWeekOf(with data: FetchedResults<Workout>) -> (() -> Void)? {
        for workout in data {
            if workout.dateRange == nil {
                let newDateRange = viewModel.findDateRangeForDate(date: workout.dateCompleted ?? Date.now)
                workout.dateRange = newDateRange
                try? moc.save()
            }
        }
        return nil
    }
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Frequently Recorded:")) {
                    ForEach(viewModel.topThreeWorkouts(workouts: workouts), id: \.self) { workout in
                        NavigationLink(destination: RecordExerciseView(workout: workout)) {
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
                    ZStack {
                        NavigationLink(destination: BreakdownHistoryView()) {
                        }
                        .buttonStyle(PlainButtonStyle())
                        .opacity(0.0)
                        Text("compare past weeks")
                            .foregroundColor(.blue)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .fontWeight(.light)
                            .onAppear(perform: reRecordWorkoutWithNoWeekOf(with: workouts)) // had to put this here, because there was an error when put on the view itself
                    }
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
        .padding(.bottom, 8)
        .navigationTitle("Dashboard")
        .navigationBarBackButtonHidden(true)
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView()
    }
}
